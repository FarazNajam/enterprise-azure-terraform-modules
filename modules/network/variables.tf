variable "rg_name" {
  type = map(string)
}

variable "location" {
  type = map(string)
}

variable "vnets" {
  type = map(object({
    name          = string
    address_space = list(string)
    dns_servers   = list(string)
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