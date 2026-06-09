resource "azurerm_app_configuration" "app_config" {
  for_each = var.app_configs
  name                       = each.value.name
  resource_group_name        = var.rg_name[each.value.rg_key]
  location                   = var.location[each.value.rg_key]
  sku                        = each.value.sku
  local_auth_enabled         = each.value.local_auth_enabled
  public_network_access      = each.value.public_network_access
  purge_protection_enabled   = each.value.purge_protection_enabled
  soft_delete_retention_days = each.value.soft_delete_retention_days
}