
resource "azurerm_resource_group" "avd" {
  name     = "avd-rg"
  location = var.location
}

resource "azurerm_virtual_desktop_host_pool" "avd-pool" {
  location            = azurerm_resource_group.avd.location
  resource_group_name = azurerm_resource_group.avd.name

  name                     = var.host_pool_name
  friendly_name            = "pooleddepthfirst"
  validate_environment     = true
  start_vm_on_connect      = true
  custom_rdp_properties    = "audiocapturemode:i:1;audiomode:i:0;"
  description              = "Acceptance Test: A pooled host pool - pooleddepthfirst"
  type                     = "Pooled"
  maximum_sessions_allowed = 2
  load_balancer_type       = "DepthFirst"

  registration_info {
    expiration_date = "2021-09-20T08:00:00Z"               # Must be set to a time between 1 hour in the future & 27 days in the future
  }
}

# Diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "avd-pool-diags" {
  name               = "adds-diags"
  target_resource_id = azurerm_virtual_desktop_host_pool.avd-pool.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.avd-workspace.id

  log {
    category = "Checkpoint"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "Error"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "Management"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "Connection"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "HostRegistration"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "AgentHealthStatus"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }
}

resource "azurerm_virtual_desktop_application_group" "desktopapp" {
  name                = "appgroupdesktop"
  location            = azurerm_resource_group.avd.location
  resource_group_name = azurerm_resource_group.avd.name

  type          = "Desktop"
  host_pool_id  = azurerm_virtual_desktop_host_pool.avd-pool.id
  friendly_name = "TestAppGroup"
  description   = "Acceptance Test: An application group"
}

resource "azurerm_monitor_diagnostic_setting" "desktopapps-appgroup-diags" {
  name               = "adds-diags"
  target_resource_id = azurerm_virtual_desktop_application_group.desktopapp.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.avd-workspace.id

  log {
    category = "Checkpoint"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "Error"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "Management"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }
}

resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = "workspace"
  location            = azurerm_resource_group.avd.location
  resource_group_name = azurerm_resource_group.avd.name

  friendly_name = "FriendlyName"
  description   = "A description of my workspace"
}

resource "azurerm_monitor_diagnostic_setting" "avd-workspace-diags" {
  name               = "adds-diags"
  target_resource_id = azurerm_virtual_desktop_workspace.workspace.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.avd-workspace.id

  log {
    category = "Checkpoint"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "Error"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "Management"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "Feed"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "workspaceremoteapp" {
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
  application_group_id = azurerm_virtual_desktop_application_group.desktopapp.id
}