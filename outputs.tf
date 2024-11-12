output "gateway-public-ip-address" {
  description = "The public IP address of the application gateway"
  value       = module.gateway.public-ip-address
}

output "linux-web-app-fqdn" {
  description = "The fully qualified domain name of the app service"
  value       = module.app_service.fqdn
}
