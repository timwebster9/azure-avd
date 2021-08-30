variable user_principal_name {
  type = string
  description = "Full UPN.  e.g. user1@mydomain.onmicrosoft.com"
}

variable display_name {
  type = string
  description = "Display name"
}

variable force_password_change {
  type = bool
  description = "Force user to change password on first login."
}

variable password {
  type = string
  description = "Initial password"
}