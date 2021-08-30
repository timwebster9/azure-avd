output "id" {
    description = "Virtual network ID"
    value       = azurerm_virtual_network.vnet.id
}

output "name" {
    description = "Virtual network name"
    value       = azurerm_virtual_network.vnet.name
}

output "aadds_subnet_id" {
    description = "AAD DS subnet ID"
    value       = azurerm_subnet.aadds_subnet.id
}