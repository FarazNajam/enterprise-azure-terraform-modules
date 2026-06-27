resource "azurerm_private_endpoint" "example" {
  name                = "example-endpoint"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.endpoint.id

  private_service_connection {
    name                           = each.value.private_service_connection.name
    private_connection_resource_id = var.private_connection_resource_ids[each.value.resource_key]
    is_manual_connection           = each.value.private_service_connection.is_manual_connection
    subresource_names = ["vault"]
  }
}
