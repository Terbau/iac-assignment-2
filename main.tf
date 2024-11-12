locals {
  rg_name = terraform.workspace == "default" ? var.rg_name : "${var.rg_name}-${terraform.workspace}"
}

resource "azurerm_resource_group" "main" {
  name     = local.rg_name
  location = var.location
}

module "keyvault" {
  source = "./modules/keyvault"

  kv_name  = "bboppg2kv"
  rg_name  = azurerm_resource_group.main.name
  location = azurerm_resource_group.main.location
  secrets  = {}
}

module "storage" {
  source = "./modules/storage"

  rg_name  = azurerm_resource_group.main.name
  location = azurerm_resource_group.main.location
  sa_name  = "bboppg2sa"
}

module "database" {
  source = "./modules/database"

  rg_name           = azurerm_resource_group.main.name
  location          = azurerm_resource_group.main.location
  mssql_server_name = "bragebau-oppg2-sql-server-001"
  mssql_db_name     = "bragebau-oppg2-db-001"
  admin_username    = "bragebau${terraform.workspace}"
  kv_id             = module.keyvault.kv_id
}

module "app_service" {
  source = "./modules/app_service"

  rg_name                 = azurerm_resource_group.main.name
  location                = azurerm_resource_group.main.location
  sp_name                 = "bragebau-oppg2-service-plan-001"
  linux_web_app_name      = "bragebau-oppg2-linux-web-app-001"
  mssql_connection_string = module.database.connection_string
  docker_image_name       = "terbau/hello-world-express:latest2"
}

module "networking" {
  source = "./modules/networking"

  rg_name             = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vnet_name           = "bragebau-oppg2-vnet-001"
  subnet_name         = "bragebau-oppg2-subnet-001"
  gateway_subnet_name = "bragebau-oppg2-gateway-subnet-001"
  nic_name            = "bragebau-oppg2-nic-001"
  nsg_name            = "bragebau-oppg2-nsg-001"
}

module "gateway" {
  source = "./modules/gateway"

  rg_name        = azurerm_resource_group.main.name
  location       = azurerm_resource_group.main.location
  public_ip_name = "bragebau-oppg2-public-ip-001"
  gw_name        = "bragebau-oppg2-gateway-001"
  subnet_id      = module.networking.gateway_subnet_id
  fqdns          = [module.app_service.fqdn]
}
