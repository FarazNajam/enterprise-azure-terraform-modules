variable "rg_name" {
  type = map(string)
}

variable "location" {
  type = map(string)
}

variable "app_configs" {
  type = map(object({
    name = string
    sku = string
    local_auth_enabled         = bool
    public_network_access      = string
    purge_protection_enabled   = bool
    soft_delete_retention_days = number
    rg_key = string
  }))
}