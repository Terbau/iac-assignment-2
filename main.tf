locals {
  rg-name = terraform.workspace == "default" ? var.rg-name : "${var.rg-name}-${terraform.workspace}"
}

resource "azurerm_resource_group" "main" {
  name     = local.rg-name
  location = var.location
}

module "keyvault" {
  source = "./modules/keyvault"

  kv-name  = "bragebauoppg2kv"
  rg-name  = azurerm_resource_group.main.name
  location = azurerm_resource_group.main.location

  secrets = {
    mssql-admin-username = var.mssql-admin-username
    mssql-admin-password = var.mssql-admin-password
  }
}

module "storage" {
  source = "./modules/storage"

  rg-name  = azurerm_resource_group.main.name
  location = azurerm_resource_group.main.location
  sa-name  = "bragebauoppg2sa"
}

module "database" {
  source = "./modules/database"

  rg-name           = azurerm_resource_group.main.name
  location          = azurerm_resource_group.main.location
  mssql-server-name = "bragebau-oppg2-sql-server-001"
  mssql-db-name     = "bragebau-oppg2-db-001"
  admin-username    = var.mssql-admin-username
  admin-password    = var.mssql-admin-password
}

module "app_service" {
  source = "./modules/app_service"

  rg-name                 = azurerm_resource_group.main.name
  location                = azurerm_resource_group.main.location
  sp-name                 = "bragebau-oppg2-service-plan-001"
  linux-web-app-name      = "bragebau-oppg2-linux-web-app-001"
  mssql-connection-string = module.database.connection-string
  docker-image-name       = "terbau/hello-world-express:latest2"
}

module "networking" {
  source = "./modules/networking"

  rg-name             = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vnet-name           = "bragebau-oppg2-vnet-001"
  subnet-name         = "bragebau-oppg2-subnet-001"
  gateway-subnet-name = "bragebau-oppg2-gateway-subnet-001"
  nic-name            = "bragebau-oppg2-nic-001"
  nsg-name            = "bragebau-oppg2-nsg-001"
}

module "gateway" {
  source = "./modules/gateway"

  rg-name        = azurerm_resource_group.main.name
  location       = azurerm_resource_group.main.location
  public-ip-name = "bragebau-oppg2-public-ip-001"
  gw-name        = "bragebau-oppg2-gateway-001"
  subnet-id      = module.networking.gateway-subnet-id
  fqdns          = [module.app_service.fqdn]
}
