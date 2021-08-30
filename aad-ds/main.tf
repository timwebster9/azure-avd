###############################
# AAD Domain Services IAM
###############################
module "dc_admin1" {
  source = "../modules/aad_user"
  user_principal_name   = var.aadds_admin1_upn
  display_name          = var.aadds_admin1_display_name
  force_password_change = true # needs changing before it can sync with AAD DS
  password              = data.azurerm_key_vault_secret.adds-admin-password.value
}

module "dc_admin2" {
  source = "../modules/aad_user"
  user_principal_name   = var.aadds_admin2_upn
  display_name          = var.aadds_admin2_display_name
  force_password_change = true # needs changing before it can sync with AAD DS
  password              = data.azurerm_key_vault_secret.adds-admin-password.value
}

resource "azuread_group" "dc_admins" {
  display_name      = "AAD DC Administrators"
  security_enabled  = true

  members = [
    module.dc_admin1.object_id,
    module.dc_admin2.object_id
  ]
}

############
# Network 
############
module "vnet_rg" {
    source = "../modules/resource-group"
    name   = "vnet-rg"
    location = var.location
}

module "aadds_vnet" {
    source              = "../modules/virtual-network"
    name                = "aadds-vnet"
    location            = var.location
    resource_group_name = module.vnet_rg.name
    address_space       = [var.aadds_vnet_cidr]
    dns_servers         = [var.aadds_dc1, var.aadds_dc2]
}

module "aadds_subnet" {
    source               = "../modules/subnet"
    name                 = "aadds-sn"
    resource_group_name  = module.vnet_rg.name
    virtual_network_name = module.aadds_vnet.name
    address_prefixes     = [var.aadds_subnet_cidr]
}

module "bastion_subnet" {
    source               = "../modules/subnet"
    name                 = "bastion-sn"
    resource_group_name  = module.vnet_rg.name
    virtual_network_name = module.aadds_vnet.name
    address_prefixes     = [var.bastion_subnet_cidr]
}

module "session_hosts_subnet" {
    source               = "../modules/subnet"
    name                 = "session-hosts-sn"
    resource_group_name  = module.vnet_rg.name
    virtual_network_name = module.aadds_vnet.name
    address_prefixes     = [var.avd_hosts_subnet_cidr]
}

###########################################
# Azure Active Directory Domain Services 
###########################################
module "aadds_rg" {
    source = "../modules/resource-group"
    name   = "aadds-rg"
    location = var.location
}

module "aadds" {
    source                = "../modules/azure-active-directory-domain-services"
    name                  = "avd-aadds"
    location              = var.location
    resource_group_name   = module.aadds_rg.name
    domain_name           = var.aadds_domain_name
    sku                   = var.aadds_sku
    subnet_id             = module.aadds_subnet.id
    additional_recipients = var.aadds_email_recipients
}