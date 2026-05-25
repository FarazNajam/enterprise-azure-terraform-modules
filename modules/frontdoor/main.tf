resource "azurerm_cdn_frontdoor_profile" "fd_profile" {
  name                = var.fd_profile
  resource_group_name = var.rg_name
  sku_name            = "Standard_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_endpoint" "fd_endpoint" {
  name                     = var.fd_endpoint
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile.id
}

resource "azurerm_cdn_frontdoor_origin_group" "fd_og" {
  name                     = var.fd_og_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile.id

  load_balancing {}
}

resource "azurerm_cdn_frontdoor_origin" "fd_origin" {
  name                          = var.fd_origin
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.fd_og.id
  host_name = var.app_hostname
  certificate_name_check_enabled = false
}

resource "azurerm_cdn_frontdoor_route" "fd_route" {
  name                          = var.fd_route
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.fd_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.fd_og.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.fd_origin.id]

  patterns_to_match   = ["/*"]
  supported_protocols = ["Http", "Https"]
}