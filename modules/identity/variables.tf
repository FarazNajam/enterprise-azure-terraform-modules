variable "identity" {
  type = map(object({
    scope = string
    role_definition_id  = string
    appservice_key = string
  }))
}
