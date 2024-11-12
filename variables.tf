variable "rg-name" {
  description = "The name of the resource group"
  type        = string
  default     = "bragebau-oppg2-rg"
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "westeurope"
}

variable "mssql-admin-username" {
  description = "The username for the database administrator"
  type        = string
}

variable "mssql-admin-password" {
  description = "The password for the database administrator"
  type        = string
  sensitive   = true
}
