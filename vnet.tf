# RG
resource "azurerm_resource_group" "avd" {
  name     = "avd-vnet-rg"
  location = var.location
}

# VNET
resource "azurerm_virtual_network" "avd" {
  name                = "avd-vnet"
  location            = azurerm_resource_group.avd_vnet_resource_group.location
  resource_group_name = azurerm_resource_group.avd_vnet_resource_group.name
  address_space       = var.cidr_avd_vnet
}

# SUBNETS
resource "azurerm_subnet" "adds-sn" {
  name                 = "adds-sn"
  resource_group_name  = azurerm_resource_group.avd_vnet_resource_group.name
  virtual_network_name = azurerm_virtual_network.avd.name
  address_prefixes     = var.cidr_adds_subnet
}




