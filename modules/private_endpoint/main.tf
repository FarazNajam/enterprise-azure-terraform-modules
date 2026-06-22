resource "azurerm_private_endpoint" "private_endpoint" {
  for_each = var.private_endpoints
  name                = each.value.name
  location            = var.location[each.value.rg_key]
  resource_group_name = var.rg_name[each.value.rg_key] 
  subnet_id           = var.subnet_ids[each.value.subnet_key]

  private_service_connection {
    name                           = each.value.private_service_connection.name
    private_connection_resource_id = var.private_connection_resource_ids[each.value.resource_key]
    is_manual_connection           = each.value.private_service_connection.is_manual_connection
    subresource_names = ["vault"]
  }
}
