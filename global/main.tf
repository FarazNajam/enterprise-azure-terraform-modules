terraform {
  backend "azurerm" {
    resource_group_name  = "TestStorageAccountTHlDr"
    storage_account_name = "tststrgaccnthldr02"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}