

resource "azurerm_servicebus_namespace" "servicebus" {
  for_each = var.service_bus
  name                = each.value.name
  location            = var.location[each.value.rg_key]
  resource_group_name = var.rg_name[each.value.rg_key]
  sku                 = each.value.sku
}