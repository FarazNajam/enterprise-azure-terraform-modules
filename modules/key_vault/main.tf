resource "azurerm_key_vault" "key_vault" {
  for_each = var.key_vaults
  name                        = each.value.name
  location                    = var.location[each.value.rg_key]
  resource_group_name         = var.rg_name[each.value.rg_key]
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled
  sku_name = each.value.sku_name
  rbac_authorization_enabled = each.value.rbac_authorization_enabled
}