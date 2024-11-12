variable "backend_rg_name" {
  description = "The name of the resource group to create for the backend storage account"
  type        = string
  default     = "bragebauoppg2rgbackend"
}

variable "backend_rg_location" {
  description = "The location of the resource group to create for the backend storage account"
  type        = string
  default     = "westeurope"
}

variable "backend_sa_name" {
  description = "The name of the storage account to create for the backend"
  type        = string
  default     = "bragebauoppg2sabackend"
}

variable "backend_kv_name" {
  description = "The name of the key vault to create for the backend"
  type        = string
  default     = "bragebauoppg2kvbackend"
  
}

variable "sa_backend_access_key_name" {
  description = "The name of the access key to use for the storage account"
  type        = string
  default     = "sa-backend-access-key"
}
