output "public-ip-id" {
  description = "The ID of the public IP"
  value       = azurerm_public_ip.main.id
}

output "public-ip-address" {
  description = "The IP address of the public IP"
  value       = azurerm_public_ip.main.ip_address
}

output "gateway-id" {
  description = "The ID of the gateway"
  value       = azurerm_application_gateway.main.id
}

