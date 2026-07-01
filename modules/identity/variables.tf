variable "identity" {
  type = map(object({
    principal_key = string
    scope = string
    role_definition_name = string
  }))
}

variable "principal_ids" {
  type = map(string)
}