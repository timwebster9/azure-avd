####################################
# Azure Active Directory Domain Services
# SP Azure AD permissions required:
#   - Global Administrator (https://docs.microsoft.com/en-us/azure/active-directory-domain-services/powershell-create-instance#prerequisites)
####################################
resource "azurerm_active_directory_domain_service" "aadds" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  domain_name           = var.domain_name
  sku                   = var.sku
  filtered_sync_enabled = false

  initial_replica_set {
    subnet_id = var.subnet_id
  }

  notifications {
    additional_recipients = var.email_recipients
    notify_dc_admins      = true
    notify_global_admins  = true
  }

  security {
    sync_kerberos_passwords = true
    sync_ntlm_passwords     = true
    sync_on_prem_passwords  = true
  }
}

# Diagnostic settings
# resource "azurerm_monitor_diagnostic_setting" "adds-diags" {
#   name               = "adds-diags"
#   target_resource_id = azurerm_active_directory_domain_service.adds.id
#   log_analytics_workspace_id = azurerm_log_analytics_workspace.avd-workspace.id

#   log {
#     category = "SystemSecurity"
#     enabled  = true
#     retention_policy {
#       enabled = false
#     }
#   }

#   log {
#     category = "AccountManagement"
#     enabled  = true
#     retention_policy {
#       enabled = false
#     }
#   }

#   log {
#     category = "LogonLogoff"
#     enabled  = true
#     retention_policy {
#       enabled = false
#     }
#   }

#   log {
#     category = "ObjectAccess"
#     enabled  = true
#     retention_policy {
#       enabled = false
#     }
#   }

#   log {
#     category = "PolicyChange"
#     enabled  = true
#     retention_policy {
#       enabled = false
#     }
#   }

#   log {
#     category = "PrivilegeUse"
#     enabled  = true
#     retention_policy {
#       enabled = false
#     }
#   }

#   log {
#     category = "DetailTracking"
#     enabled  = true
#     retention_policy {
#       enabled = false
#     }
#   }

#   log {
#     category = "DirectoryServiceAccess"
#     enabled  = true
#     retention_policy {
#       enabled = false
#     }
#   }

#   log {
#     category = "AccountLogon"
#     enabled  = true
#     retention_policy {
#       enabled = false
#     }
#   }
# }