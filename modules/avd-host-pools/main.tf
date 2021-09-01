resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_desktop_host_pool" "avd_pool" {
  for_each = var.host_pools

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  name                     = each.value.name
  friendly_name            = each.value.name
  validate_environment     = true
  start_vm_on_connect      = true
  custom_rdp_properties    = "audiocapturemode:i:1;audiomode:i:0;"
  description              = each.value.description
  type                     = each.value.type 
  maximum_sessions_allowed = each.value.max_sessions
  load_balancer_type       = each.value.load_balancer_type 

  registration_info {
    expiration_date = var.registration_expiry_date
  }
}