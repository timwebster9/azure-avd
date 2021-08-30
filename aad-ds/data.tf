data "azurerm_key_vault" "mgmt-kv" {
  name                = var.mgmt_keyvault_name
  resource_group_name = var.mgmt_keyvault_rg
}

data "azurerm_key_vault_secret" "adds-admin-password" {
  name         = var.aadds_admin_password_secret
  key_vault_id = data.azurerm_key_vault.mgmt-kv.id
}
