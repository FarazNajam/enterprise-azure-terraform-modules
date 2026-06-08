resource "azurerm_network_security_group" "nsg" {
for_each = var.nsgs
  name                = each.value.name
  location            = var.location[each.value.rg_key]
  resource_group_name = var.rg_name[each.value.rg_key]
}
