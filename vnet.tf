# RG
resource "azurerm_resource_group" "avd-vnet" {
  name     = "avd-vnet-rg"
  location = var.location
}

# VNET
# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.0.0.0&mask=16&division=25.fff0000
resource "azurerm_virtual_network" "avd" {
  name                = "avd-vnet"
  location            = azurerm_resource_group.avd-vnet.location
  resource_group_name = azurerm_resource_group.avd-vnet.name
  address_space       = [var.cidr_avd_vnet]
  dns_servers         = [var.adds_dc1_ip, var.adds_dc2_ip]
}

# SUBNETS
resource "azurerm_subnet" "adds-sn" {
  name                 = "adds-sn"
  resource_group_name  = azurerm_resource_group.avd-vnet.name
  virtual_network_name = azurerm_virtual_network.avd.name
  address_prefixes     = [var.cidr_adds_subnet]
}

resource "azurerm_subnet" "avd-hosts-sn" {
  name                 = "avd-hosts-sn"
  resource_group_name  = azurerm_resource_group.avd-vnet.name
  virtual_network_name = azurerm_virtual_network.avd.name
  address_prefixes     = [var.cidr_avd_hosts_subnet]
}

resource "azurerm_subnet" "avd-bastion-sn" {
  name                 = "avd-bastion-sn"
  resource_group_name  = azurerm_resource_group.avd-vnet.name
  virtual_network_name = azurerm_virtual_network.avd.name
  address_prefixes     = [var.cidr_bastion_subnet]
}

# Bastion subnet NSG
resource "azurerm_network_security_group" "bastion" {
  name                = "bastion-nsg"
  location            = azurerm_resource_group.avd-vnet.location
  resource_group_name = azurerm_resource_group.avd-vnet.name

  security_rule {
    name                       = "AllowSyncWithAzureAD"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "212.159.71.60"
    destination_address_prefix = "*"
  }
}

resource azurerm_subnet_network_security_group_association "bastion-nsg-assoc" {
  subnet_id                 = azurerm_subnet.avd-bastion-sn.id
  network_security_group_id = azurerm_network_security_group.bastion.id
}

# AD DS NSG
resource "azurerm_network_security_group" "adds" {
  name                = "adds-nsg"
  location            = azurerm_resource_group.avd-vnet.location
  resource_group_name = azurerm_resource_group.avd-vnet.name

  security_rule {
    name                       = "AllowSyncWithAzureAD"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "AzureActiveDirectoryDomainServices"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowRD"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "CorpNetSaw"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowPSRemoting"
    priority                   = 301
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = "AzureActiveDirectoryDomainServices"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowLDAPS"
    priority                   = 401
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "636"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource azurerm_subnet_network_security_group_association "adds-nsg-assoc" {
  subnet_id                 = azurerm_subnet.adds-sn.id
  network_security_group_id = azurerm_network_security_group.adds.id
}




