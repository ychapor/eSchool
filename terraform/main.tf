# Create a resource group
resource "azurerm_resource_group" "app_rg" {
  name     = var.app_rg_name
  location = var.app_rg_location
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "app_vnet" {
  name                = var.app_vnet_name
  resource_group_name = azurerm_resource_group.app_rg.name
  location            = azurerm_resource_group.app_rg.location
  address_space       = var.app_vnet_cidr
  depends_on          = [azurerm_resource_group.app_rg]
}
