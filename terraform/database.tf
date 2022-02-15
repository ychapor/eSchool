# Subnet for MySQL Flexible Server
resource "azurerm_subnet" "db_subnet" {
  name                 = var.db_subnet_name
  resource_group_name  = azurerm_resource_group.app_rg.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name
  address_prefixes     = var.db_subnet_cidr
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_private_dns_zone" "db_private_dns" {
  name                = "${var.db_name}.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.app_rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "db_private_dns_link" {
  name                  = var.db_private_dns_link_name
  private_dns_zone_name = azurerm_private_dns_zone.db_private_dns.name
  virtual_network_id    = azurerm_virtual_network.app_vnet.id
  resource_group_name   = azurerm_resource_group.app_rg.name
}

# Create DB password
resource "random_password" "db_password" {
  length  = 20
  special = true
}

# Create Key Vault secret
resource "azurerm_key_vault_secret" "kv_db_password" {
  name         = var.db_key_vault_password_secret_name
  value        = random_password.db_password.result
  key_vault_id = azurerm_key_vault.tf_key_vault.id
  depends_on   = [azurerm_key_vault.tf_key_vault]
}

resource "azurerm_mysql_flexible_server" "tf_mysql_db" {
  name                   = var.db_name
  resource_group_name    = azurerm_resource_group.app_rg.name
  location               = azurerm_resource_group.app_rg.location
  administrator_login    = var.tf_db_username
  administrator_password = azurerm_key_vault_secret.kv_db_password.value
  backup_retention_days  = 7
  delegated_subnet_id    = azurerm_subnet.db_subnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.db_private_dns.id
  sku_name               = var.tf_mysql_db_sku_name
  depends_on = [azurerm_private_dns_zone_virtual_network_link.db_private_dns_link,
  azurerm_key_vault_secret.kv_db_password]
}