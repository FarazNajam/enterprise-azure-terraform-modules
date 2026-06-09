variable "rg_name" {
  type = map(string)
}

variable "location" {
  type = map(string)
}

variable "tenant_id" {
  type = string
}

variable "key_vaults" {
  type = map(object({
    name = string
    enabled_for_disk_encryption = bool
    soft_delete_retention_days = number
    purge_protection_enabled = bool
    sku_name = string
    rbac_authorization_enabled = bool
    rg_key = string
  }))
}