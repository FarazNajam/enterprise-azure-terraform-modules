variable "rg_name" {
  type = map(string)
}

variable "location" {
  type = map(string)
}

variable "storage_accounts" {
  type = map(object({
    name = string
    account_tier = string
    account_replication_type = string
    rg_key = string
  }))
}