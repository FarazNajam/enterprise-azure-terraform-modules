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
