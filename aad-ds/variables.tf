###########################
# Management Dependencies 
###########################
variable mgmt_keyvault_rg {
  type = string
  description = "Management Key Vault resource group"
}

variable mgmt_keyvault_name {
  type = string
  description = "Management Key Vault"
}

variable aadds_admin_password_secret {
  type = string
  description = "Key Vault secret name for AA DS admin password"
}

#####################
# Resource location 
#####################
variable location {
  type = string
  description = "Azure region"
}

############
# Network 
############
variable aadds_vnet_cidr {
  type = string
  description = "AAD DS VNet CIDR"
}

variable aadds_subnet_cidr {
  type = string
  description = "AAS DS subnet CIDR"
}

variable bastion_subnet_cidr {
  type = string
  description = "Bastion subnet CIDR"
}

variable sessionhost_subnet_cidr {
  type = string
  description = "Session hosts subnet CIDR"
}

variable aadds_dc1 {
  type = string
  description = "AAD DS DC 1 IP address"
}

variable aadds_dc2 {
  type = string
  description = "AAD DS DC server 2 IP address"
}

###########################################
# Azure Active Directory Domain Services 
###########################################
variable aadds_domain_name {
  type = string
  description = "AAD DS domain name"
}

variable aadds_sku {
  type = string
  description = "AAD DS SKU"
}

variable aadds_email_recipients {
  type = list
  description = "AAD DS notification email recipients"
}

variable aadds_admin1_upn {
  type = string
  description = "AAD DS primary admin user UPN"
}

variable aadds_admin1_display_name {
  type = string
  description = "AAD DS primary admin user display name"
}

variable aadds_admin2_upn {
  type = string
  description = "AAD DS secondary admin user UPN"
}

variable aadds_admin2_display_name {
  type = string
  description = "AAD DS secondary admin user display name"
}