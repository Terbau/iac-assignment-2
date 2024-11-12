locals {
  kv_name = terraform.workspace == "default" ? var.kv_name : "${var.kv_name}${terraform.workspace}"
}

data "azurerm_client_config" "current" {}

resource "random_string" "this" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_key_vault" "main" {
  name                        = "${local.kv_name}${random_string.this.result}"
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]

    storage_permissions = [
      "Get",
      "Set",
      "Delete",
    ]
  }
}

resource "azurerm_key_vault_secret" "this" {
  for_each = var.secrets

  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.main.id
}
