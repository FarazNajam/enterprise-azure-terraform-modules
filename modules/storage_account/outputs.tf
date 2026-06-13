output "storage_account_ids" {
  value = {
    for k, strg in azurerm_storage_account.storage_account :
    k => strg.id
  }
}