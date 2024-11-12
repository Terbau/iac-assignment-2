variable "nsg_name" {
  description = "The name of the network security group"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "gateway_subnet_name" {
  description = "The name of the gateway subnet"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "westeurope"
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "nic_name" {
  description = "The name of the network interface"
  type        = string
}

