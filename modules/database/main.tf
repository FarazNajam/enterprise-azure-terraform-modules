resource "azurerm_mssql_server" "mssql_server" {
  for_each = var.sqlservers
  name                         = each.value.name
  resource_group_name          = var.rg_name[each.value.rg_key]
  location                     = var.location[each.value.rg_key]
  version                      = each.value.version
  administrator_login          = each.value.admin_login
  administrator_login_password = each.value.admin_password
}

resource "azurerm_mssql_database" "mssql_db" {
  for_each = var.sqldatabases
  name           = each.value.name
  server_id      = azurerm_mssql_server.mssql_server[each.value.server_key].id
  sku_name       = each.value.sku_name
}
