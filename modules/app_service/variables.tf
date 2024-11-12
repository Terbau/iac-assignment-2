variable "rg-name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "westeurope"
}

variable "sp-name" {
  description = "The name of the service plan"
  type        = string
}

variable "linux-web-app-name" {
  description = "The name of the Linux web app"
  type        = string
}

variable "app-settings" {
  description = "The app settings for the app service"
  type        = map(string)
  default     = {}
}

variable "mssql-connection-string" {
  description = "The connection string for the MSSQL database"
  type        = string
}

variable "docker-image-name" {
  description = "The name of the Docker image"
  type        = string
}
