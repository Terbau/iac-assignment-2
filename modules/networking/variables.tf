variable "nsg-name" {
  description = "The name of the network security group"
  type        = string
}

variable "vnet-name" {
  description = "The name of the virtual network"
  type        = string
}

variable "subnet-name" {
  description = "The name of the subnet"
  type        = string
}

variable "gateway-subnet-name" {
  description = "The name of the gateway subnet"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "westeurope"
}

variable "rg-name" {
  description = "The name of the resource group"
  type        = string
}

variable "nic-name" {
  description = "The name of the network interface"
  type        = string
}

