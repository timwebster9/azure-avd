############
# General 
############
variable "location" {
  type = string
  description = "location"
}

############
# Network 
############
variable "cidr_avd_vnet" {
  type = string
  description = "AVD vnet address space"
}

variable "cidr_adds_subnet" {
    type = "string"
    description = "AD DS subnet address space"
}