variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "westeurope"
}

variable "mssql_server_name" {
  description = "The name of the MSSQL server"
  type        = string
}

variable "mssql_db_name" {
  description = "The name of the MSSQL database"
  type        = string
}

variable "kv_id" {
  description = "The ID of the Key Vault to store the credentials in"
  type        = string
}

variable "admin_username" {
  description = "The username for the MSSQL server"
  type        = string
}
