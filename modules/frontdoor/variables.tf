variable "rg_name" {
  type        = string
}

variable "fd_profile" {
  description = "Name of the Azure Front Door profile"
  type        = string
}

variable "app_hostname" {
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
  description = "Name of the Front Door origin"
  type        = string
}