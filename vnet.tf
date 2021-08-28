# RG
resource "azurerm_resource_group" "avd-vnet" {
  name     = "avd-vnet-rg"
  location = var.location
}

# VNET
resource "azurerm_virtual_network" "avd" {
  name                = "avd-vnet"
  location            = azurerm_resource_group.avd-vnet.location
  resource_group_name = azurerm_resource_group.avd-vnet.name
  address_space       = [var.cidr_avd_vnet]
}

# SUBNETS
resource "azurerm_subnet" "adds-sn" {
  name                 = "adds-sn"
  resource_group_name  = azurerm_resource_group.avd-vnet.name
  virtual_network_name = azurerm_virtual_network.avd.name
  address_prefixes     = [var.cidr_adds_subnet]
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




