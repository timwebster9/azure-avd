data "azurerm_key_vault" "mgmt-kv" {
  name                = "mgmtkvtimw"
  resource_group_name = "mgmt-rg"
}

data "azurerm_key_vault_secret" "adds-admin-password" {
  name         = "adds-admin-password"
  key_vault_id = data.azurerm_key_vault.mgmt-kv.id
}