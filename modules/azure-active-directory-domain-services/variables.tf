variable name {
  type = string
  description = "AAD DS name"
}

variable location {
  type = string
  description = "AAD DS location"
}

variable resource_group_name {
  type = string
  description = "AAD DS resource group name"
}

variable domain_name {
  type = string
  description = "AAD DS domain name"
}

variable sku {
  type = string
  description = "AAD DS SKU"
}

variable subnet_id {
  type = string
  description = "AAD DS subnet ID"
}

variable email_recipients {
  type = list
  description = "AAD DS notification email recipients"
}