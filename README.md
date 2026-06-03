# Terraform Azure Modules

## Overview

This repository contains reusable Terraform modules for deploying common Azure infrastructure components.

The goal of this project is to provide a scalable, environment-agnostic Infrastructure as Code (IaC) framework that supports deployment of Azure resources using Terraform modules and Terraform `for_each` patterns.

The modules are designed to support deployments ranging from a single resource instance to multiple resources across different environments and subscriptions.

---

## Features

- Reusable Terraform modules
- Azure-focused platform and application services
- Scalable `map(object())` design patterns
- Support for `for_each` deployments
- Environment-agnostic architecture
- Modular and maintainable code structure
- Suitable for Dev, Test, UAT, and Production environments

---

## Available Modules

| Module | Description |
|----------|----------|
| resource_group | Deploy Azure Resource Groups |
| network | Deploy VNets and Subnets |
| nsg | Deploy Network Security Groups |
| route_table | Deploy Azure Route Tables |
| public_ip | Deploy Azure Public IP addresses |
| app_service | Deploy App Service Plans and Web Apps |
| database | Deploy Azure SQL Servers and Databases |
| frontdoor | Deploy Azure Front Door Profiles, Endpoints, Origin Groups, Origins and Routes |
| storage_account | Deploy Azure Storage Accounts |
| key_vault | Deploy Azure Key Vault |
| app_config | Deploy Azure App Configuration |
| service_bus | Deploy Azure Service Bus |
| managed_identity | Deploy User Assigned Managed Identities |
| log_analytics | Deploy Log Analytics Workspaces |
| monitor_alerts | Deploy Azure Monitor Alerts |

---

## Repository Structure

```text
.
├── modules
│   ├── resource_group
│   ├── network
│   ├── nsg
│   ├── route_table
│   ├── public_ip
│   ├── app_service
│   ├── database
│   ├── frontdoor
│   ├── storage_account
│   ├── key_vault
│   ├── app_config
│   ├── service_bus
│   ├── managed_identity
│   ├── log_analytics
│   └── monitor_alerts
│
├── examples
├── README.md
└── LICENSE
```

---

## Example Usage

### Resource Group

```hcl
module "rg" {
  source   = "./modules/resource_group"

  rg_name  = "rg-prod-aue-01"
  location = "Australia East"
}
```

### Network

```hcl
module "network" {
  source   = "./modules/network"

  rg_name  = module.rg.rg_name
  location = module.rg.location

  vnets   = var.vnets
  subnets = var.subnets
}
```

Example variables:

```hcl
vnets = {
  vnet_app = {
    name          = "vnet-prod-aue-01"
    address_space = ["10.0.0.0/16"]
    dns_servers   = ["10.0.0.4", "10.0.0.5"]
  }
}

subnets = {
  subnet_app = {
    name             = "subnet-app"
    address_prefixes = ["10.0.1.0/24"]
    vnet_key         = "vnet_app"
  }
}
```

### App Service

```hcl
module "app" {
  source = "./modules/app_service"

  rg_name      = module.rg.rg_name
  location     = module.rg.location
  app_services = var.app_services
}
```

### Front Door

```hcl
module "frontdoor" {
  source = "./modules/frontdoor"

  rg_name      = module.rg.rg_name
  fd_profile   = var.fd_profile
  fd_endpoint  = var.fd_endpoint

  app_hostname = module.app.default_hostnames

  fd_og_name   = var.fd_og_name
  fd_route     = var.fd_route
}
```

---

## Design Principles

### Reusability

Modules are designed to be reused across multiple environments and subscriptions.

### Scalability

Modules support deployment of one or many resources using Terraform collections and `for_each`.

### Dependency Mapping

Relationships between resources are modelled using reference keys such as:

- `vnet_key`
- `server_key`
- `app_key`

### Environment Agnostic

The same modules can be used in:

- Development
- Test
- UAT
- Production

without changing module code.

---

## Future Modules

Planned additions include:

- Azure Firewall
- Bastion
- Recovery Services Vault
- Private Endpoints
- Azure Kubernetes Service (AKS)
- Azure Functions
- Event Grid
- Event Hub
- API Management
- Application Gateway

---

## Technologies

- Terraform
- Azure Resource Manager (ARM)
- GitHub
- Azure Networking
- Azure Security Services
- Azure Monitoring
- Azure App Services
- Azure SQL Database
- Azure Front Door

---

## Disclaimer

This project is intended for learning, portfolio development, and reusable Infrastructure as Code deployment patterns.

Review all configurations and security settings before using in production environments.
