locals {
  sa-name = terraform.workspace == "default" ? var.sa-name : "${var.sa-name}${terraform.workspace}"
}

resource "random_string" "this" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_storage_account" "main" {
  name                     = "${local.sa-name}${random_string.this.result}"
  resource_group_name      = var.rg-name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
