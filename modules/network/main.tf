
resource "azurerm_virtual_network" "vnet" {
  for_each = var.vnets
  name     = each.value.name
  location = var.location[each.value.rg_key]
  resource_group_name = var.rg_name[each.value.rg_key]
  address_space = each.value.address_space
}

resource "azurerm_subnet" "subnets" {
  for_each = var.subnets
  name                 = each.value.name
  resource_group_name  = var.rg_name[each.value.rg_key]
  virtual_network_name = azurerm_virtual_network.vnet[each.value.vnet_key].name
  address_prefixes     = each.value.address_prefixes

    dynamic "delegation" {
    for_each = each.value.delegation == null ? [] : [each.value.delegation]

    content {
      name = delegation.value.name

      service_delegation {
        name = delegation.value.service

        actions = [
          "Microsoft.Network/virtualNetworks/subnets/action"
        ]
      }
    }
  }
}