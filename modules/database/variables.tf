variable "rg-name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "westeurope"
}

variable "mssql-server-name" {
  description = "The name of the MSSQL server"
  type        = string
}

variable "mssql-db-name" {
  description = "The name of the MSSQL database"
  type        = string
}

variable "admin-username" {
  description = "The username for the database administrator"
  type        = string
}

variable "admin-password" {
  description = "The password for the database administrator"
  type        = string
  sensitive   = true
}
