
resource "azurerm_network_security_group" "nsg" {
  name                = "example-security-group"
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = "example-network"
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name             = "subnet_app"
    address_prefixes = ["10.0.1.0/24"]
    security_group   = azurerm_network_security_group.nsg.id

  }

  subnet {
    name             = "subnet_db"
    address_prefixes = ["10.0.2.0/24"]
    security_group   = azurerm_network_security_group.nsg.id
  }

}