variable "rg_name" {
  type        = map(string)
}

variable "location" {
  type        = map(string)
}

variable "fd_profile" {
  type = map(object({
    name = string
    sku = string
    response_timeout_seconds = number
    rg_key = string
  }))
}

variable "app_hostname" {
  type        = map(string)
}

variable "fd_endpoint" {
  description = "Name of the Front Door endpoint"
  type        = string
}

variable "fd_og_name" {
  description = "Name of the Front Door origin group"
  type        = string
}

variable "fd_route" {
  description = "Name of the Front Door origin"
  type        = string
}