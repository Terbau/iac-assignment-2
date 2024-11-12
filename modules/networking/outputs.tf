output "nic-id" {
  description = "The ID of the network interface"
  value       = azurerm_network_interface.main.id
}

output "subnet-id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.main.id
}

output "gateway-subnet-id" {
  description = "The ID of the gateway subnet"
  value       = azurerm_subnet.gateway.id
}

output "vnet-id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "vnet-name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.main.name
}
