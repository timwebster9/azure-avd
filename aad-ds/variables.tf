variable location {
  type = string
  description = "Azure region"
}

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

variable avd_hosts_subnet_cidr {
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