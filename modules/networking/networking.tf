locals {
  nsg_name            = terraform.workspace == "default" ? var.nsg_name : "${var.nsg_name}-${terraform.workspace}"
  vnet_name           = terraform.workspace == "default" ? var.vnet_name : "${var.vnet_name}-${terraform.workspace}"
  subnet_name         = terraform.workspace == "default" ? var.subnet_name : "${var.subnet_name}-${terraform.workspace}"
  gateway_subnet_name = terraform.workspace == "default" ? var.gateway_subnet_name : "${var.gateway_subnet_name}-${terraform.workspace}"
  nic_name            = terraform.workspace == "default" ? var.nic_name : "${var.nic_name}-${terraform.workspace}"
}

resource "azurerm_network_security_group" "main" {
  name                = local.nsg_name
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "Allow_AppGateway_Inbound_Traffic"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_HTTP_Inbound_Traffic"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_HTTPS_Inbound_Traffic"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_virtual_network" "main" {
  name                = local.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "main" {
  name                 = local.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "gateway" {
  name                 = local.gateway_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = azurerm_subnet.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_subnet_network_security_group_association" "gateway" {
  subnet_id                 = azurerm_subnet.gateway.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_network_interface" "main" {
  name                = local.nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
  }
}
