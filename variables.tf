########################################
# RG VARIABLES
########################################

variable "resource_groups" {
  type = map(object({
    name = string
    location = string
    tags = map(string)
  }))
}

########################################
# NETWORK VARIABLES
########################################

variable "vnets" {
  type = map(object({
    name = string
    address_space = list(string)
    dns_servers = list(string)
    rg_key = string
  }))
}

variable "nsgs" {
  type = map(object({
    name = string
    rg_key = string
  }))
}

variable "subnets" {
  type = map(object({
    name = string
    address_prefixes  = list(string)
    vnet_key = string
    rg_key = string
  }))
}

########################################
# APP VARIABLES
########################################

variable "app_services" {
  type = map(object({
    app_service_plan_name = string
    app_service_name  = string
    rg_key = string
  }))
}
########################################
# DB VARIABLES
########################################

variable "sqlservers" {
  type = map(object({
    name = string
    version = string
    admin_login  = string
    admin_password = string
    rg_key = string
  }))
}

variable "sqldatabases" {
  type = map(object({
    name = string
    sku_name = string
    server_key = string
  }))
}

########################################
# FRONT DOOR VARIABLES
########################################

#variable "fd_profile" {
#  type = map(object({
#    name = string
#    sku = string
#    response_timeout_seconds = number
#    rg_key = string
#  }))
#}

#variable "fd_endpoint" {
#  description = "Name of the Front Door endpoint"
#  type        = string
#}

#variable "fd_og_name" {
#  description = "Name of the Front Door origin group"
#  type        = string
#}

#variable "fd_route" {
#  description = "Name of the Front Door route"
#  type        = string
#}

