locals {
  public_ip_name = terraform.workspace == "default" ? var.public_ip_name : "${var.public_ip_name}-${terraform.workspace}"
  gw_name        = terraform.workspace == "default" ? var.gw_name : "${var.gw_name}-${terraform.workspace}"
}

resource "azurerm_public_ip" "main" {
  name                = local.public_ip_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "main" {
  name                = local.gw_name
  location            = var.location
  resource_group_name = var.rg_name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.subnet_id
  }

  frontend_ip_configuration {
    name                 = "appGatewayFrontendIP"
    public_ip_address_id = azurerm_public_ip.main.id
  }

  frontend_port {
    name = "httpPort"
    port = 80
  }

  backend_address_pool {
    name  = "storageBackendPool"
    fqdns = var.fqdns
  }

  http_listener {
    name                           = "httpListener"
    frontend_ip_configuration_name = "appGatewayFrontendIP"
    frontend_port_name             = "httpPort"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    priority                   = 10
    rule_type                  = "Basic"
    http_listener_name         = "httpListener"
    backend_address_pool_name  = "storageBackendPool"
    backend_http_settings_name = "backendHttpsSettings"
  }

  backend_http_settings {
    name                                = "backendHttpsSettings"
    cookie_based_affinity               = "Disabled"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 20
    pick_host_name_from_backend_address = true
  }
}
