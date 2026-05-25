terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "rg" {
  source   = "./modules/resource_group"
  rg_name  = var.rg_name
  location = var.location
  tags     = var.tags
}

module "network" {
  source   = "./modules/network"
  rg_name  = module.rg.rg_name
  location = module.rg.location
}

module "app" {
  source   = "./modules/app_service"
  rg_name  = module.rg.rg_name
  location = module.rg.location
  app_service_name      = var.app_service_name
  app_service_plan_name = var.app_service_plan_name
}

module "db" {
  source   = "./modules/database"
  rg_name  = module.rg.rg_name
  location = module.rg.location
  server_name = var.server_name
  db_name   = var.db_name
  admin_user = var.admin_user
  admin_pass = var.admin_pass
}

module "frontdoor" {
  source   = "./modules/frontdoor"
  rg_name  = module.rg.rg_name
  fd_profile       = var.fd_profile
  fd_endpoint      = var.fd_endpoint
  app_hostname     = module.app.default_hostname
  fd_og_name       = var.fd_og_name
  fd_origin        = var.fd_origin
  fd_route         = var.fd_route
}
