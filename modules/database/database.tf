locals {
  mssql-server-name = terraform.workspace == "default" ? var.mssql-server-name : "${var.mssql-server-name}-${terraform.workspace}"
  mssql-db-name     = terraform.workspace == "default" ? var.mssql-db-name : "${var.mssql-db-name}-${terraform.workspace}"
}

resource "azurerm_mssql_server" "main" {
  name                         = local.mssql-server-name
  resource_group_name          = var.rg-name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin-username
  administrator_login_password = var.admin-password
}

resource "azurerm_mssql_database" "this" {
  name         = local.mssql-db-name
  server_id    = azurerm_mssql_server.main.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"
}
