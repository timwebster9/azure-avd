data "azurerm_key_vault" "mgmt-kv" {
  name                = "timwmgmtkv"
  resource_group_name = "mgmt-rg"
}

data "azurerm_key_vault_secret" "adds-admin-password" {
  name         = "adds-admin-password"
  key_vault_id = data.azurerm_key_vault.mgmt-kv.id
}

data "azurerm_key_vault_secret" "avd-user-password" {
  name         = "avd-user-password"
  key_vault_id = data.azurerm_key_vault.mgmt-kv.id
}

data "azurerm_key_vault_secret" "avd-user1-password" {
  name         = "avd-user1-password"
  key_vault_id = data.azurerm_key_vault.mgmt-kv.id
}