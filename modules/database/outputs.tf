output "sqlserver_ids" {
  value = {
    for k, db in azurerm_mssql_server.mssql_server :
    k => db.id
  }
}

output "sqlserver_fqdns" {
  value = {
    for k, s in azurerm_mssql_server.mssql_server :
    k => s.fully_qualified_domain_name
  }
}

output "database_ids" {
  value = {
    for k, db in azurerm_mssql_database.mssql_db :
    k => db.id
  }
}

output "database_names" {
  value = {
    for k, db in azurerm_mssql_database.mssql_db :
    k => db.name
  }
}
