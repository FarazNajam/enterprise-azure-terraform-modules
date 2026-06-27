locals {
    identity = {
 kv-secrets-reader = {
  principal_key = "flask-app"
  scope = module.key_vault.key_vault_ids["key_vault_flaskapp"]
  role_definition_name = "Key Vault Secrets User"
 }

 storage-reader = {
  principal_key = "flask-app"
  scope = module.storage_account.storage_account_ids["storage_account_flaskapp"]
  role_definition_name = "Storage Blob Data Reader"
 }
}
}