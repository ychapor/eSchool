# Create KeyVault
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "tf_key_vault" {
  depends_on                  = [azurerm_resource_group.app_rg]
  name                        = var.tf_key_vault_name
  location                    = var.app_rg_location
  resource_group_name         = var.app_rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "get",
    ]
    secret_permissions = [
      "get", "backup", "delete", "list", "purge", "recover", "restore", "set",
    ]
    storage_permissions = [
      "get",
    ]
  }
}
