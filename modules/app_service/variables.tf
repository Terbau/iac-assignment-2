variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "westeurope"
}

variable "sp_name" {
  description = "The name of the service plan"
  type        = string
}

variable "linux_web_app_name" {
  description = "The name of the Linux web app"
  type        = string
}

variable "app_settings" {
  description = "The app settings for the app service"
  type        = map(string)
  default     = {}
}

variable "mssql_connection_string" {
  description = "The connection string for the MSSQL database"
  type        = string
}

variable "docker_image_name" {
  description = "The name of the Docker image"
  type        = string
}
