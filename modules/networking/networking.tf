locals {
  nsg-name            = terraform.workspace == "default" ? var.nsg-name : "${var.nsg-name}-${terraform.workspace}"
  vnet-name           = terraform.workspace == "default" ? var.vnet-name : "${var.vnet-name}-${terraform.workspace}"
  subnet-name         = terraform.workspace == "default" ? var.subnet-name : "${var.subnet-name}-${terraform.workspace}"
  gateway-subnet-name = terraform.workspace == "default" ? var.gateway-subnet-name : "${var.gateway-subnet-name}-${terraform.workspace}"
  nic-name            = terraform.workspace == "default" ? var.nic-name : "${var.nic-name}-${terraform.workspace}"
}

resource "azurerm_network_security_group" "main" {
  name                = local.nsg-name
  location            = var.location
  resource_group_name = var.rg-name

  security_rule {
    name                       = "Allow-AppGateway-Inbound-Traffic"
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
    name                       = "Allow-HTTP-Inbound-Traffic"
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
    name                       = "Allow-HTTPS-Inbound-Traffic"
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
  name                = local.vnet-name
  location            = var.location
  resource_group_name = var.rg-name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "main" {
  name                 = local.subnet-name
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "gateway" {
  name                 = local.gateway-subnet-name
  resource_group_name  = var.rg-name
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
  name                = local.nic-name
  location            = var.location
  resource_group_name = var.rg-name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
  }
}
