# Configure tfstate storage
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = var.tf_rg_name
    storage_account_name = var.tf_sa_name
    container_name       = var.tf_c_name
    key                  = var.tf_s_key
  }
}

# Configure the Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "app_rg" {
  name     = var.app_rg_name
  location = var.app_rg_location
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "eschool_vnet" {
  name                = "eschool-vnet"
  resource_group_name = azurerm_resource_group.app_rg.name
  location            = azurerm_resource_group.app_rg.location
  address_space       = ["10.0.0.0/16"]
}