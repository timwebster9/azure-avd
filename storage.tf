resource "azurerm_resource_group" "avd_storage_rg" {
  name     = "avd-storage-rg"
  location = var.location
}

resource "azurerm_storage_account" "avd_storage" {
  name                          = "avdstorage345354355"
  resource_group_name           = azurerm_resource_group.avd_storage_rg.name
  location                      = azurerm_resource_group.avd_storage_rg.location
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  access_tier                   = "Hot"
  enable_https_traffic_only     = "true"
  min_tls_version               = "TLS1_2"
  allow_blob_public_access      = "false"

  azure_files_authentication {
    directory_type = "AADDS"
  }
}

resource "azurerm_role_assignment" "dc_admin_fileshares" {
  scope                = azurerm_storage_account.avd_storage.id # AVD storage account
  role_definition_name = "Storage File Data SMB Share Elevated Contributor"
  principal_id         = azuread_group.dc_admins.object_id      # AD DS admins group
}

resource "azurerm_storage_share" "avd_profiles_share" {
  name                 = "avd-profiles"
  storage_account_name = azurerm_storage_account.avd_storage.name
  quota                = 10
}
