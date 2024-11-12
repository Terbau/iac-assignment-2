output "sp-id" {
  description = "The ID of the service plan"
  value       = azurerm_service_plan.main.id
}

output "fqdn" {
  description = "The fully qualified domain name of the app service"
  value       = azurerm_linux_web_app.main.default_hostname
}