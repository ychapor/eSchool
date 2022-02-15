# Configure tfstate storage
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "xxx"
    storage_account_name = "xxx"
    container_name       = "xxx"
    key                  = "xxx"
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
