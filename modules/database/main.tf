resource "azurerm_mssql_server" "mssql_server" {
  for_each = var.sqlservers
  name                         = each.value.name
  resource_group_name          = var.rg_name[each.value.rg_key]
  location                     = var.location[each.value.rg_key]
  version                      = each.value.version
  
  azuread_administrator {
    login_username              = each.value.entra_admin_login
    object_id                   = each.value.entra_admin_object_id
    tenant_id                   = data.azurerm_client_config.current.tenant_id
    azuread_authentication_only = true
  }
}

resource "azurerm_mssql_database" "mssql_db" {
  for_each = var.sqldatabases
  name           = each.value.name
  server_id      = azurerm_mssql_server.mssql_server[each.value.server_key].id
  sku_name       = each.value.sku_name
}
