output "key_vault_ids" {
  value = {
    for k, kv in azurerm_key_vault.key_vault :
    k => kv.id
  }
}