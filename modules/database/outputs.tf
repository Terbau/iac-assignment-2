output "mssql-server-id" {
  description = "The ID of the MSSQL server"
  value       = azurerm_mssql_server.main.id
}

output "fully-qualified-domain-name" {
  description = "The fully qualified domain name of the MSSQL server"
  value       = azurerm_mssql_server.main.fully_qualified_domain_name
}

output "mssql-database-id" {
  description = "The ID of the MSSQL database"
  value       = azurerm_mssql_database.this.id
}

output "connection-string" {
  description = "The connection string for the MSSQL database"
  value       = "Server=${azurerm_mssql_server.main.fully_qualified_domain_name};Database=${azurerm_mssql_database.this.name};User Id=${azurerm_mssql_server.main.administrator_login};Password=${azurerm_mssql_server.main.administrator_login_password};"
  sensitive   = true
}
