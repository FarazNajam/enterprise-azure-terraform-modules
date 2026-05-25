resource "azurerm_mssql_server" "mssql_server" {
  name                         = var.server_name
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_user
  administrator_login_password = var.admin_pass
}

resource "azurerm_mssql_database" "mssql_db" {
  name           = var.db_name
  server_id      = azurerm_mssql_server.mssql_server.id
  sku_name       = "S0"
}
