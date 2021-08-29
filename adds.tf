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

  domain_name           = var.adds_domain
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

  depends_on = [
    azuread_group_member.dc_admin_group_assignment
  ]
}

# Diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "adds-diags" {
  name               = "adds-diags"
  target_resource_id = azurerm_active_directory_domain_service.adds.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.avd-workspace.id

  log {
    category = "SystemSecurity"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "AccountManagement"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "LogonLogoff"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "ObjectAccess"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "PolicyChange"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "PrivilegeUse"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "DetailTracking"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "DirectoryServiceAccess"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "AccountLogon"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }
}