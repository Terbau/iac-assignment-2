output "gateway_public_ip_address" {
  description = "The public IP address of the application gateway"
  value       = module.gateway.public_ip_address
}

output "linux_web_app_fqdn" {
  description = "The fully qualified domain name of the app service"
  value       = module.app_service.fqdn
}
