variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "westeurope"
}

variable "public_ip_name" {
  description = "The name of the public IP"
  type        = string
}

variable "gw_name" {
  description = "The name of the gateway"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "fqdns" {
  description = "The Fully qualified domain names that the backend pool of the application gateway will use"
  type        = list(string)
}
