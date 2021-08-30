variable name {
  type = string
  description = "Virtual network name"
}

variable location {
  type = string
  description = "Virtual network location"
}

variable resource_group_name {
  type = string
  description = "Virtual network resource group name"
}

variable address_space {
  type = list
  description = "Virtual network address space"
}

variable dns_servers {
  type = list
  description = "Virtual network DNS servers"
  default = []
}