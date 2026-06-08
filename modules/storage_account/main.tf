resource "azurerm_storage_account" "storage_account" {
  for_each = var.storage_accounts
  name                     = each.value.storage_account_name
  resource_group_name      = var.rg_name[each.value.rg_key]
  location                 = var.location[each.value.rg_key]
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}