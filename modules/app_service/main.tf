resource "azurerm_service_plan" "asp" {
  for_each = var.app_services
  name                = each.value.app_service_plan_name
  resource_group_name = var.rg_name[each.value.rg_key]
  location            = var.location[each.value.rg_key]
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "as" {
  for_each = var.app_services
  name                = each.value.app_service_name
  resource_group_name = var.rg_name[each.value.rg_key]
  location            = var.location[each.value.rg_key]
  service_plan_id     = azurerm_service_plan.asp[each.key].id
  
  site_config {
    always_on = "false"
  }
}