resource "azurerm_resource_group" "workspace" {
  name     = "avd-workspace-rg"
  location = var.location
}

resource "azurerm_log_analytics_workspace" "avd-workspace" {
  name                = "avd-workspace"
  location            = azurerm_resource_group.workspace.location
  resource_group_name = azurerm_resource_group.workspace.name
  sku                 = "Free"
  retention_in_days   = 7
}