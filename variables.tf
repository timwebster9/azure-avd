############
# General 
############
variable "location" {
  type        = string
  description = "location"
}

############
# Network 
############
variable "cidr_avd_vnet" {
  type        = string
  description = "AVD vnet address space"
}

variable "cidr_adds_subnet" {
    type        = string
    description = "AD DS subnet address space"
}

variable "cidr_bastion_subnet" {
    type        = string
    description = "Bastion subnet address space"
}

variable "cidr_avd_hosts_subnet" {
    type        = string
    description = "AVD hosts subnet address space"
}

variable "adds_dc1_ip" {
    type        = string
    description = "AD DS domain controller 1 IP address"
}

variable "adds_dc2_ip" {
    type        = string
    description = "AD DS domain controller 2 IP address"
}

#####################
# AD Domain Services 
#####################
variable "adds_domain" {
    type        = string
    description = "AD DS domain name"
}

variable "adds_admin_username" {
    type        = string
    description = "AD DS admin user"
}

variable "adds_admin" {
    type        = string
    description = "AD DS admin user with local domain name"
}

#########################
# Azure Virtual Desktop 
#########################
variable "host_pool_name" {
    type        = string
    description = "AVD host pool name"
}