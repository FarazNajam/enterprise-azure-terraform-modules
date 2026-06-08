resource "azurerm_cdn_frontdoor_profile" "fd_profile" {
  for_each = var.fd_profile
  name                = each.value.name
  resource_group_name = var.rg_name[each.value.rg_key]
  sku_name            = each.value.sku
  response_timeout_seconds = each.value.response_timeout_seconds
}

resource "azurerm_cdn_frontdoor_endpoint" "fd_endpoint" {
  for_each = var.fd_profile
  name                     = var.fd_endpoint
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile[each.key].id
}

resource "azurerm_cdn_frontdoor_origin_group" "fd_og" {
  for_each = var.fd_profile
  name                     = var.fd_og_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile[each.key].id

  load_balancing {}
}

resource "azurerm_cdn_frontdoor_origin" "fd_origin" {
  for_each = var.app_hostname
  name                          = each.key
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.fd_og.id[each.key]
  host_name = each.value
  certificate_name_check_enabled = false
}

resource "azurerm_cdn_frontdoor_route" "fd_route" {
  for_each = var.app_hostname
  name = "${var.fd_route}-${each.key}"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.fd_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.fd_og.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.fd_origin[each.key].id]
  enabled = true
  patterns_to_match   = ["/*"]
  supported_protocols = ["Http", "Https"]
}