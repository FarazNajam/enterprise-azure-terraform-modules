resource "azurerm_network_security_group" "nsg" {
for_each = var.nsgs
  name                = each.value.name
  location            = var.location[each.value.rg_key]
  resource_group_name = var.rg_name[each.value.rg_key]
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
for_each = var.nsg_associations
  subnet_id = var.subnet_id[each.value.subnet_key]
  network_security_group_id = azurerm_network_security_group.nsg[each.value.nsg_key].id
}