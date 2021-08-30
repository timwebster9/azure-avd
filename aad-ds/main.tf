###############################
# AAD Domain Services IAM
###############################
resource "azuread_user" "dc_admin1" {
  user_principal_name     = var.aadds_admin1_upn
  display_name            = var.aadds_admin1_display_name
  force_password_change   = false # default setting but including for info
  password                = data.azurerm_key_vault_secret.adds-admin-password.value
}

resource "azuread_user" "dc_admin2" {
  user_principal_name     = var.aadds_admin2_upn
  display_name            = var.aadds_admin2_display_name
  force_password_change   = false # default setting but including for info
  password                = data.azurerm_key_vault_secret.adds-admin-password.value
}

resource "azuread_group" "dc_admins" {
  display_name      = "AAD DC Administrators"
  security_enabled  = true

  members = [
    azuread_user.dc_admin1.object_id,
    azuread_user.dc_admin2.object_id
  ]
}

############
# Network 
############
module "aadds_vnet" {
    source                  = "../modules/virtual-network"
    location                = var.location
    resource_group_name     = "vnet-rg"
    vnet_name               = "aadds-vnet"
    vnet_address_space      = [var.aadds_vnet_cidr]
    dns_servers             = [var.aadds_dc1, var.aadds_dc2]
    aadds_subnet_name       = "aadds-sn"
    aadds_subnet_cidr       = [var.aadds_subnet_cidr]
    bastion_subnet_name     = "bastion-sn"
    bastion_subnet_cidr     = [var.bastion_subnet_cidr]
    sessionhost_subnet_name = "session-hosts-sn"
    sessionhost_subnet_cidr = [var.sessionhost_subnet_cidr]
}

###########################################
# Azure Active Directory Domain Services 
###########################################
module "aadds" {
    source                = "../modules/azure-active-directory-domain-services"
    name                  = "avd-aadds"
    location              = var.location
    resource_group_name   = "aadds-rg"
    domain_name           = var.aadds_domain_name
    sku                   = var.aadds_sku
    subnet_id             = module.aadds_vnet.aadds_subnet_id
    email_recipients      = var.aadds_email_recipients
}