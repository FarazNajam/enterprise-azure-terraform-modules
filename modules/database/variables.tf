variable "rg_name" {
  type        = map(string)
}

variable "location" {
  type        = map(string)
}

variable "sqlservers" {
  type = map(object({
    name = string
    version = string
    entra_admin_login  = string
    entra_admin_object_id = string
    rg_key = string
  }))
}

variable "tenant_id" {
  type        = string
}

variable "sqldatabases" {
  type = map(object({
    name = string
    sku_name = string
    server_key = string
  }))
}
