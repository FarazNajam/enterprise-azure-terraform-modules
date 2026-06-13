variable "rg_name" {
  type = map(string)
}

variable "location" {
  type = map(string)
}

variable "subnet_id" {
  type = map(string)
}

variable "private_connection_resource_id" {
  type = map(string)
}

variable "private_endpoints" {
  type = map(object({
    name = string
    private_service_connection = object({
      name                = string
      is_manual_connection = bool
    })
    rg_key = string
    subnet_key = string
    kv_key = string

  }))
}

