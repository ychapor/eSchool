variable "tf_rg_name" {
  description = "tfstate resource group name"
  default     = ""
}

variable "tf_sa_name" {
  description = "tfstate storage account name"
  default = ""
}

variable "tf_c_name" {
  description = "tfstate storage container name"
  default = ""
}

variable "tf_s_key" {
  description = "tfstate storage key"
  default = ""
}

variable "app_rg_name" {
  description = "Web application resource group name"
  default     = ""
}

variable "app_rg_location" {
  description = "Web application resource group location"
  default     = ""
}
