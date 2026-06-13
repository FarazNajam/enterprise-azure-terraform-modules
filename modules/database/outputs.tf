output "database_ids" {
  value = {
    for k, db in azurerm_mssql_server.mssql_server :
    k => db.id
  }
}