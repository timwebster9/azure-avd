variable vnet_name {
  type = string
  description = "Virtual network name"
}

variable location {
  type = string
  description = "Virtual network location"
}

variable resource_group_name {
  type = string
}

variable vnet_address_space {
  type = list
}

variable dns_servers {
  type = list
  default = []
}

variable aadds_subnet_name {
  type = string
}

variable aadds_subnet_cidr {
  type = list
}

variable bastion_subnet_name {
  type = string
}

variable bastion_subnet_cidr {
  type = list
}

variable sessionhost_subnet_name {
  type = string
}

variable sessionhost_subnet_cidr {
  type = list
}