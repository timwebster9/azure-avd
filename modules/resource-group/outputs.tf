output "id" {
    description = "resource group ID"
    value       = azurerm_resource_group.rg.id
}

output "name" {
    description = "resource group name"
    value       = azurerm_resource_group.rg.name
}

output "location" {
    description = "resource group location"
    value       = azurerm_resource_group.rg.location
}