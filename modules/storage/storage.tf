locals {
  sa_name = terraform.workspace == "default" ? var.sa_name : "${var.sa_name}${terraform.workspace}"
}

resource "random_string" "this" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_storage_account" "main" {
  name                     = "${local.sa_name}${random_string.this.result}"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
