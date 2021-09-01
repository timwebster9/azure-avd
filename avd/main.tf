module "host_pools" {
    source = "../modules/avd-host-pools"
    resource_group_name      = "avd-rg"
    location                 = var.location
    host_pools               = var.host_pools
    registration_expiry_date = var.registration_expiry_date
}