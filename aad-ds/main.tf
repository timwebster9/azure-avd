module "vnet_rg" {
    source = "../modules/resource-group"
    name   = "vnet-rg"
    location = var.location
}