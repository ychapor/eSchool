# Configure tfstate storage
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-app-terraform"
    storage_account_name = "tfstatestorageyc"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

# Configure the Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg_eschool_terraform" {
  name     = "rg-eschool-terraform"
  location = "East US"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "eschool_vnet" {
  name                = "eschool-vnet"
  resource_group_name = azurerm_resource_group.rg_eschool_terraform.name
  location            = azurerm_resource_group.rg_eschool_terraform.location
  address_space       = ["10.0.0.0/16"]
}