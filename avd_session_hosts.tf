resource "azurerm_resource_group" "avd-hosts" {
  name     = "avd-hosts-rg"
  location = var.location
}

