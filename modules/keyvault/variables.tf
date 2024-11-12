variable "kv-name" {
  description = "The name of the key vault"
  type        = string
}

variable "rg-name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "westeurope"
}

variable "secrets" {
  description = "A map of secrets to store in the key vault"
  type        = map(string)
  default     = {}
}
