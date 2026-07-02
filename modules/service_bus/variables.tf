variable "rg_name" {
  type = map(string)
}

variable "location" {
  type = map(string)
}

variable "service_bus" {
  type = map(object({
    name = string
    sku = string
    rg_key = string
  }))
}