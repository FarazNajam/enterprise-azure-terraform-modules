resource "azurerm_role_assignment" "role_assignment" {
  for_each = var.identity
  scope              = each.value.scope
  role_definition_id = each.value.role_definition_id
  principal_id       = var.principal_ids[each.value.principal_key]
}