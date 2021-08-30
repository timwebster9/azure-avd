resource "azuread_user" "user" {
  user_principal_name     = var.user_principal_name
  display_name            = var.display_name # "DC Administrator"
  force_password_change   = var.force_password_change
  password                = var.password
}