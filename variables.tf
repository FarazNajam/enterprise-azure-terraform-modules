########################################
# RG VARIABLES
########################################

variable "rg_name" {
  type        = string
}

variable "location" {
  type        = string
}

variable "tags" {
  type        = map(string)
}

########################################
# NETWORK VARIABLES
########################################

########################################
# APP VARIABLES
########################################

variable "app_service_name" {
  type        = string
}

variable "app_service_plan_name" {
  type        = string
}

########################################
# DB VARIABLES
########################################

variable "server_name" {
  type        = string
}

variable "db_name" {
  type        = string
}

variable "admin_user" {
  type        = string
}

variable "admin_pass" {
  type        = string
}


########################################
# FRONT DOOR VARIABLES
########################################

variable "fd_profile" {
  description = "Name of the Azure Front Door profile"
  type        = string
}

variable "fd_endpoint" {
  description = "Name of the Front Door endpoint"
  type        = string
}

variable "fd_og_name" {
  description = "Name of the Front Door origin group"
  type        = string
}

variable "fd_origin" {
  description = "Name of the Front Door origin"
  type        = string
}

variable "fd_route" {
  description = "Name of the Front Door route"
  type        = string
}
