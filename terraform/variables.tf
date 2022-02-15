variable "app_rg_name" {
  description = "Web application resource group name"
  type = string
}

variable "app_rg_location" {
  description = "Web application resource group location"
  type = string
}

variable "app_vnet_name" {
  description = "Name of the VNet where application will reside"
  type = string
}

variable "app_vnet_cidr" {
  description = "CIDR notation of the VNet where application will reside"
  type        = list(any)
  default     = []
}