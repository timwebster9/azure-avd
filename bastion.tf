resource "azurerm_resource_group" "bastion-hosts" {
  name     = "bastion-hosts-rg"
  location = var.location
}

resource "azurerm_public_ip" "bastion_pip" {
  name                = "bastion-pip"
  resource_group_name = azurerm_resource_group.bastion-hosts.name
  location            = azurerm_resource_group.bastion-hosts.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "bastion_nic" {
  name                = "bastion-nic"
  resource_group_name = azurerm_resource_group.bastion-hosts.name
  location            = azurerm_resource_group.bastion-hosts.location

  ip_configuration {
    name                          = "bastionhost1"
    subnet_id                     = azurerm_subnet.avd-bastion-sn.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_pip.id
  }
}

resource "azurerm_windows_virtual_machine" "bastion" {
  name                  = "bastion-vm"
  resource_group_name   = azurerm_resource_group.bastion-hosts.name
  location              = azurerm_resource_group.bastion-hosts.location
  size                  = "Standard_D4s_v3"
  network_interface_ids = [ azurerm_network_interface.bastion_nic.id ]
  
  admin_username = "azureuser"
  admin_password = data.azurerm_key_vault_secret.bastion-vm-password.value
    
  os_disk {
    name                 = "disk1"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "microsoftwindowsserver"
    offer     = "windowsserver"
    sku       = "2019-Datacenter"                                 
    version   = "latest"
  }
}