########################################
# RESOURCE GROUP
########################################

resource_groups = {
  flask_app = {
    name = "rg-prod-aue-01"
    location  = "Australia East"
    tags = {
    environment = "prod"
    owner       = "cloud-team"
    managed_by  = "terraform"
    }
  }  
}
########################################
# APP SERVICE
########################################

app_services = {
  flask-app = {
    app_service_plan_name = "asp-prod-aue-01"
    app_service_name  = "app-prod-aue-01"
    rg_key = "flask_app"
  }
}

########################################
# VNET
########################################

vnets = {
  vnet_flaskapp = {
    name = "p-auea-flask_app-vnet"
    address_space = ["10.0.0.0/16"]
    dns_servers = ["10.0.0.4","10.0.0.5"]
    rg_key = "flask_app"
  }
}

nsgs = {
  nsg_flaskapp = {
    name = "p-auea-flask_app-vnet"
    rg_key = "flask_app"
  }
}

subnets = {
  subnet_app = {
    name = "subnet_app"
    address_prefixes = ["10.0.1.0/24"]
    vnet_key = "vnet_flaskapp"
    rg_key = "flask_app"
  }

  subnet_db = {
    name = "subnet_db"
    address_prefixes = ["10.0.2.0/24"]
    vnet_key = "vnet_flaskapp"
    rg_key = "flask_app"
  }
}

########################################
# DATABASE
########################################

sqlservers = {
  sqlserver_flaskapp = {
    name = "p-auea-flaskapp-sqlserver"
    version = "12.0"
    admin_login= "sqladmin"
    admin_password = "ReplaceWithSecurePassword123"
    rg_key = "flask_app"
  }
}

sqldatabases = {
  sqldatabase_flaskapp = {
    name = "p-auea-flask_app-sqldatabase01"
    sku_name = "basic"
    server_key = "sqlserver_flaskapp"
  }
}

########################################
# FRONT DOOR
########################################

#fd_profile = {
#  fd_profile_flaskapp = {
#    name = "fd-prod-aue-01"
#    sku = "Standard_AzureFrontDoor"
#    response_timeout_seconds = 120
#    rg_key = "flask_app"
#  }
#}

#fd_endpoint = "fde-prod-aue-01"
#fd_og_name  = "fdog-prod-aue-01"
#fd_route    = "fdroute-prod-aue-01"

########################################
# STORAGE ACCOUNT
########################################

storage_accounts = {
  storage_account_flaskapp = {
    name = "p-auea-flask_app-storage_account"
    sku_name = "hot"
    account_replication_type = "LRS"
    rg_key = "flask_app"
  }
}