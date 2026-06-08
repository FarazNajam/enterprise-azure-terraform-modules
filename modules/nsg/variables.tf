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