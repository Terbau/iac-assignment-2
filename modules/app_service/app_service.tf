locals {
  sp_name            = terraform.workspace == "default" ? var.sp_name : "${var.sp_name}-${terraform.workspace}"
  linux_web_app_name = terraform.workspace == "default" ? var.linux_web_app_name : "${var.linux_web_app_name}-${terraform.workspace}"
}

resource "azurerm_service_plan" "main" {
  name                = local.sp_name
  resource_group_name = var.rg_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "B1"
}

// Using the azurerm_linux_web_app resource type instead of azurerm_app_service as the latter
// is soon to be deprecated.
resource "azurerm_linux_web_app" "main" {
  name                = local.linux_web_app_name
  resource_group_name = var.rg_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    cors {
      allowed_origins = ["*"]
    }

    application_stack {
      docker_image_name = var.docker_image_name
      docker_registry_url = "https://docker.io"
    }
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    WEBSITES_PORT                       = "8080"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = var.mssql_connection_string
  }
}
