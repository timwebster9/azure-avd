###########################
# Management Dependencies 
###########################
mgmt_keyvault_rg            = "mgmt-rg"
mgmt_keyvault_name          = "timwmgmtkv"
aadds_admin_password_secret = "adds-admin-password"

location = "uksouth"

############
# Network 
############
aadds_vnet_cidr          = "10.0.0.0/16"
aadds_subnet_cidr        = "10.0.0.0/28"
bastion_subnet_cidr      = "10.0.0.16/28"
sessionhost_subnet_cidr  = "10.0.0.64/26"

aadds_dc1 = "10.0.0.4"
aadds_dc2 = "10.0.0.5"

allow_bastion_rdp_ip = "212.159.71.60"

###########################################
# Azure Active Directory Domain Services 
###########################################
aadds_domain_name         = "avd.net"
aadds_sku                 = "Standard"
aadds_email_recipients    = ["tim.webster@contino.io"]
aadds_admin1_upn          = "dc-admin@timwebster9outlookcom.onmicrosoft.com"
aadds_admin1_display_name = "DC Administrator"
aadds_admin2_upn          = "dc-admin2@timwebster9outlookcom.onmicrosoft.com"
aadds_admin2_display_name = "DC Administrator 2"