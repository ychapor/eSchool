# Main variables
variable "app_rg_name" {
  description = "Web application resource group name"
  type        = string
}
variable "app_rg_location" {
  description = "Web application resource group location"
  type        = string
}
variable "app_vnet_name" {
  description = "Name of the VNet where application will reside"
  type        = string
}
variable "app_vnet_cidr" {
  description = "CIDR notation of the VNet where application will reside"
  type        = list(any)
}

# Database variables
variable "db_name" {
  description = "MySQL Flexible Server database name"
  type        = string
}
variable "db_subnet_name" {
  description = "Name of subnet for MySQL Flexible Server"
  type        = string
}
variable "db_subnet_cidr" {
  description = "CIDR notation of subnet for MySQL Flexible Server"
  type        = list(any)
}
variable "db_private_dns_link_name" {
  description = "Private DNS for database link name"
  type        = string
}
variable "tf_mysql_db_sku_name" {
  description = "Database SKU name"
  type        = string
}
variable "tf_db_username" {
  description = "Database SKU name"
  type        = string
  sensitive   = true
}
variable "db_key_vault_password_secret_name" {
  description = "Key vault secret name for DB password"
  type        = string
}

# Key Vault variables
variable "tf_key_vault_name" {
  description = "Key vault name for storing secrets for web app and database"
  type        = string
}
variable "key_vault_sku_name" {
  description = "KeyVault SKU name"
  type        = string
}
