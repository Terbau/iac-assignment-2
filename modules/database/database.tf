locals {
  mssql_server_name = terraform.workspace == "default" ? var.mssql_server_name : "${var.mssql_server_name}-${terraform.workspace}"
  mssql_db_name     = terraform.workspace == "default" ? var.mssql_db_name : "${var.mssql_db_name}-${terraform.workspace}"
}

resource "random_password" "password" {
  length           = 20
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_mssql_server" "main" {
  name                         = local.mssql_server_name
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_username
  administrator_login_password = random_password.password.result
}

resource "azurerm_mssql_database" "this" {
  name         = local.mssql_db_name
  server_id    = azurerm_mssql_server.main.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"
}

resource "azurerm_key_vault_secret" "mssql_admin_username" {
  name         = "mssql-admin-username"
  value        = var.admin_username
  key_vault_id = var.kv_id
}

resource "azurerm_key_vault_secret" "mssql_admin_password" {
  name         = "mssql-admin-password"
  value        = random_password.password.result
  key_vault_id = var.kv_id
}
