############
# General 
############
location = "uksouth"

############
# Network 
############
cidr_avd_vnet           = "10.0.0.0/16"
cidr_adds_subnet        = "10.0.0.0/28"
cidr_avd_hosts_subnet   = "10.0.0.64/26"

adds_dc1_ip             = "10.0.0.4"
adds_dc2_ip             = "10.0.0.5"

#####################
# AD Domain Services 
#####################
adds_admin_username = "dc-admin@timwebster9outlookcom.onmicrosoft.com"
adds_admin = "dc-admin@avd.net"

#########################
# Azure Virtual Desktop 
#########################
host_pool_name = "pooleddepthfirst"