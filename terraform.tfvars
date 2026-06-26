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
    deployment  = "terraform"
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
    subnet_key = "subnet_app"
  }
}

app_services_vnet_integration = {
  flask-app = {
    appservice_key = "flask-app"
    subnet_key  = "subnet_app"
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
    name = "paueaflaskappstrg"
    account_tier = "Standard"
    account_replication_type = "LRS"
    rg_key = "flask_app"
  }
}

########################################
# KEY VAULT
########################################

key_vaults = {
  key_vault_flaskapp = {
    name = "p-auea-flaskapp-kv01s"
    enabled_for_disk_encryption = true
    soft_delete_retention_days = 7
    purge_protection_enabled = false
    sku_name = "standard"
    rbac_authorization_enabled = true
    rg_key = "flask_app"
  }
}

########################################
# KEY VAULT SECRETS
########################################

key_vault_secrets = {
  secret_sqlserver_ids = {
    name          = "sqlserverid"
    sqlserver_key = "sqlserver_flaskapp"
    key_vault_key = "key_vault_flaskapp"
  }

    secret_sqlserver_fqdns = {
    name          = "sqlserverfqdn"
    sqlserver_key = "sqlserver_flaskapp"
    key_vault_key = "key_vault_flaskapp"
  }

    secret_database_ids= {
    name          = "databaseid"
    sqlserver_key = "sqlserver_flaskapp"
    key_vault_key = "key_vault_flaskapp"
  }

    secret_database_names = {
    name          = "databasename"
    sqlserver_key = "sqlserver_flaskapp"
    key_vault_key = "key_vault_flaskapp"
  }
}

########################################
# APP CONFIG
########################################

app_configs = {
  app_config_flaskapp = {
    name = "p-auea-flaskapp-appconfig01"
    sku = "standard"
    local_auth_enabled = false
    public_network_access = "enabled"
    purge_protection_enabled = false
    soft_delete_retention_days = 1
    rg_key = "flask_app"
  }
}

########################################
# VIRTUAL MACHINES
########################################

nics= {
  nic01_vm01 = {
    network_interface_name = "p-auea-flaskapp-nic01"
    ip_configuration = {
      name = "internal"
      subnet_key = "subnet_app"
      private_ip_address_allocation = "Dynamic"
    }
    rg_key = "flask_app"
  }
}

vms = {}

#vms= {
#  vm01 = {
#    name = "p-auea-flaskapp-vm01"
#    nic_key = "nic01_vm01"
#    subnet_key = "subnet_app"
#    rg_key = "flask_app"
#    vm_size = "Standard_B2s"
#    computer_name = "vm01"
#    admin_username = "admin01"
#    admin_password = "Faraznajam1985!"
#  }
#}

private_endpoints= {
  pep_kv01 = {
    name = "p-auea-flaskapp-pep_kv01"
    private_service_connection = {
      name = "internal"
      is_manual_connection = false
    }
    rg_key = "flask_app"
    subnet_key = "subnet_app"
    resource_key = "key_vault_flaskapp"
  }
}