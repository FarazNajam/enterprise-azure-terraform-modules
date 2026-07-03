resource "azurerm_role_assignment" "role_assignment" {
  for_each = var.role_assignments
  scope              = each.value.scope
  role_definition_name = each.value.role_definition_name
  principal_id       = var.principal_ids[each.value.principal_key]
}