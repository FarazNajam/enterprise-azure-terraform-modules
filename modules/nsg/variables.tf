variable "nsgs" {
  type = map(object({
    name = string
    rg_key = string
  }))
}

variable "rg_name" {
  type = map(string)
}

variable "location" {
  type = map(string)
}

variable "nsg_associations" {
  type = map(object({
    subnet_key = string
    nsg_key    = string
  }))
}

variable "subnet_id" {
  type = map(string)
}
