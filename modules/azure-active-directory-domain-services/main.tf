####################################
# Azure Active Directory Domain Services
# SP Azure AD permissions required:
#   - Global Administrator (https://docs.microsoft.com/en-us/azure/active-directory-domain-services/powershell-create-instance#prerequisites)
####################################


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