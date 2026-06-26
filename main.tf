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

data "azurerm_client_config" "current" {}

module "rg" {
  source   = "./modules/resource_group"
  resource_groups = var.resource_groups
}

module "network" {
  source   = "./modules/network"
  rg_name = module.rg.rg_name
  location = module.rg.location
  vnets = var.vnets
  subnets = var.subnets
}

module "nsg" {
  source = "./modules/nsg"
  rg_name = module.rg.rg_name
  location = module.rg.location
  nsgs = var.nsgs
}

module "app" {
  source   = "./modules/app_service"
  rg_name  = module.rg.rg_name
  location = module.rg.location
  app_services = var.app_services
  app_services_vnet_integration = var.app_services_vnet_integration
  subnet_id = module.network.subnet_id
}

module "db" {
  source   = "./modules/database"
  rg_name  = module.rg.rg_name
  location = module.rg.location
  sqlservers = var.sqlservers
  sqldatabases = var.sqldatabases
}

#module "frontdoor" {
#  source   = "./modules/frontdoor"
#  rg_name  = module.rg.rg_name
#  location = module.rg.location
#  fd_profile       = var.fd_profile
#  fd_endpoint      = var.fd_endpoint
#  app_hostname     = module.app.default_hostnames
#  fd_og_name       = var.fd_og_name
#  fd_route         = var.fd_route
# }

module "storage_account" {
  source   = "./modules/storage_account"
  rg_name  = module.rg.rg_name
  location = module.rg.location
  storage_accounts = var.storage_accounts
}

module "key_vault" {
  source   = "./modules/key_vault"
  rg_name  = module.rg.rg_name
  location = module.rg.location
  tenant_id = data.azurerm_client_config.current.tenant_id
  key_vaults = var.key_vaults
  key_vault_secrets = var.key_vault_secrets
  secret_sqlserver_ids = module.db.sqlserver_ids
  secret_sqlserver_fqdns = module.db.sqlserver_fqdns
  secret_database_ids = module.db.database_ids
  secret_database_names = module.db.database_names

}

module "app_config" {
  source   = "./modules/app_config"
  rg_name  = module.rg.rg_name
  location = module.rg.location
  app_configs = var.app_configs
}

module "virtual_machines" {
  source   = "./modules/vms"
  rg_name  = module.rg.rg_name
  location = module.rg.location
  subnet_id = module.network.subnet_id
  vms = var.vms
  nics = var.nics
}

module "private_endpoints" {
  source   = "./modules/private_endpoint"
  rg_name  = module.rg.rg_name
  location = module.rg.location
  subnet_ids = module.network.subnet_id
  
  private_connection_resource_ids = merge(
  module.key_vault.key_vault_ids)

  #private_connection_resource_ids = merge(
  #module.key_vault.key_vault_ids,
  #module.storage_account.storage_account_ids,
  #module.db.database_ids)

  private_endpoints = var.private_endpoints
}