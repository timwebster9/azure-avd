####################################
# Active Directory Domain Services
# SP Azure AD permissions required:
#   - Global Administrator (https://docs.microsoft.com/en-us/azure/active-directory-domain-services/powershell-create-instance#prerequisites)
####################################
resource "azurerm_resource_group" "adds" {
  name     = "adds-rg"
  location = var.location
}

resource "azurerm_active_directory_domain_service" "adds" {
  name                = "avd-adds"
  location            = azurerm_resource_group.adds.location
  resource_group_name = azurerm_resource_group.adds.name

  domain_name           = "avd.net"
  sku                   = "Standard"
  filtered_sync_enabled = false

  initial_replica_set {
    subnet_id = azurerm_subnet.adds-sn.id
  }

  notifications {
    additional_recipients = ["tim.webster@contino.io"]
    notify_dc_admins      = true
    notify_global_admins  = true
  }

  security {
    sync_kerberos_passwords = true
    sync_ntlm_passwords     = true
    sync_on_prem_passwords  = true
  }
}