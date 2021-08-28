resource "azurerm_resource_group" "adds" {
  name     = "adds-rg"
  location = var.location
}

resource "azuread_group" "dc_admins" {
  display_name      = "AAD DC Administrators"
  security_enabled  = true
}

resource "azuread_user" "dc_admin" {
  user_principal_name = "dc-admin@timwebster9outlookcom.onmicrosoft.com"
  display_name        = "DC Administrator"
  password            = "AVDpassword!"
}

resource "azuread_group_member" "admin" {
  group_object_id  = azuread_group.dc_admins.object_id
  member_object_id = azuread_user.dc_admin.object_id
}

