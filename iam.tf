###############################
# AAD Domain Services Admin
###############################
resource "azuread_group" "dc_admins" {
  display_name      = "AAD DC Administrators"
  security_enabled  = true

  members = [ 
      azuread_user.dc_admin.object_id
   ]
}

resource "azuread_user" "dc_admin" {
  user_principal_name = var.adds_admin_username
  display_name        = "DC Administrator"
  password            = data.azurerm_key_vault_secret.adds-admin-password.value
}

resource "azurerm_role_assignment" "dc_admin_fileshares" {
  scope                = azurerm_storage_account.avd_storage.id # AVD storage account
  role_definition_id   = "a7264617-510b-434b-a828-9731dc254ea7" # Storage File Data SMB Share Elevated Contributor
  principal_id         = azuread_user.dc_admin.object_id        # AD DS admin
}

###############################
# Azure Virtual Desktop Users
###############################
resource "azuread_group" "avd_users" {
  display_name      = "AVD Users"
  security_enabled  = true

  members = [ 
      azuread_user.avd_user.object_id,
      azuread_user.avd_user1.object_id
   ]
}

resource "azuread_user" "avd_user" {
  user_principal_name = "avduser@timwebster9outlookcom.onmicrosoft.com"
  display_name        = "AVD User"
  password            = data.azurerm_key_vault_secret.avd-user1-password.value
}

resource "azuread_user" "avd_user1" {
  user_principal_name = "avduser1@timwebster9outlookcom.onmicrosoft.com"
  display_name        = "AVD User1"
  password            = data.azurerm_key_vault_secret.avd-user1-password.value
}

# Role assignment for AVD file shares
resource "azurerm_role_assignment" "avd_users_storage" {
  scope                = azurerm_storage_account.avd_storage.id # AVD storage account
  role_definition_id   = "0c867c2a-1d8c-454a-a3db-ab2ea1bdc8bb" # Storage File Data SMB Share Contributor
  principal_id         = azuread_group.avd_users.object_id      # AVD Users group
}

# Role assignment for AVD applicaton groups
resource "azurerm_role_assignment" "avd_users_storage" {
  scope                = azurerm_virtual_desktop_application_group.desktopapp.id # Desktop application group
  role_definition_id   = "1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63"                  # Desktop Virtualization User
  principal_id         = azuread_group.avd_users.object_id                       # AVD Users group
}