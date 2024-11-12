variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "westeurope"
}

variable "sa_name" {
  description = "The name of the storage account"
  type        = string
}
