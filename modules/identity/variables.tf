variable "identity" {
  type = map(object({
    principal_key = string
    scope = string
    rolr_definition_name = number
  }))
}

variable "principal_ids" {
  type = map(string)
}