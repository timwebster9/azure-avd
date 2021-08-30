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