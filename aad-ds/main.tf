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