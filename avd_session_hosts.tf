# Session host TF borrowed from https://github.com/nnellans/terraform-wvd
resource "azurerm_resource_group" "avd-hosts" {
  name     = "avd-hosts-rg"
  location = var.location
}

resource "azurerm_network_interface" "wvd_vm1_nic" {
  name                = "NicNameGoesHere"
  resource_group_name = azurerm_resource_group.avd-hosts.name
  location            = azurerm_resource_group.avd-hosts.location

  ip_configuration {
    name                          = "host1"
    subnet_id                     = azurerm_subnet.avd-hosts-sn.id
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "wvd_vm1" {
  name                  = "host1"
  resource_group_name   = azurerm_resource_group.avd-hosts.name
  location              = azurerm_resource_group.avd-hosts.location
  size                  = "Standard_D2s_v3"
  network_interface_ids = [ azurerm_network_interface.wvd_vm1_nic.id ]
  
  admin_username = "azureuser"
  admin_password = "LocalPass2021"
    
  os_disk {
    name                 = "disk1"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "20h2-evd"                                 # This is the Windows 10 Enterprise Multi-Session image
    version   = "latest"
  }
}

# VM Extension for Domain-join
resource "azurerm_virtual_machine_extension" "vm1ext_domain_join" {
  name                       = "domainjoinextension"
  virtual_machine_id         = azurerm_windows_virtual_machine.wvd_vm1.id
  publisher                  = "Microsoft.Compute"
  type                       = "JsonADDomainExtension"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true

  settings = <<-SETTINGS
    {
      "Name": "avd.net",
      "OUPath": "",
      "User": "${var.adds_admin_username}",
      "Restart": "true",
      "Options": "3"
    }
    SETTINGS

  protected_settings = <<-PSETTINGS
    {
      "Password":"${data.azurerm_key_vault_secret.adds-admin-password.value}"
    }
    PSETTINGS

  lifecycle {
    ignore_changes = [ settings, protected_settings ]
  }

  depends_on = [ azurerm_active_directory_domain_service.adds ]
}

resource "azurerm_virtual_machine_extension" "vm1ext_dsc" {
  name                       = "avdsessionhostextension"
  virtual_machine_id         = azurerm_windows_virtual_machine.wvd_vm1.id
  publisher                  = "Microsoft.Powershell"
  type                       = "DSC"
  type_handler_version       = "2.73"
  auto_upgrade_minor_version = true
  
  settings = <<-SETTINGS
    {
      "modulesUrl": "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration.zip",
      "configurationFunction": "Configuration.ps1\\AddSessionHost",
      "properties": {
        "hostPoolName": "${var.host_pool_name}",
        "registrationInfoToken": "${azurerm_virtual_desktop_host_pool.avd-pool.registration_info[0].token}"
      }
    }
    SETTINGS

  lifecycle {
    ignore_changes = [ settings ]
  }

  depends_on = [ azurerm_virtual_machine_extension.vm1ext_domain_join ]
}