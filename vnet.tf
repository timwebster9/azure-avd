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




