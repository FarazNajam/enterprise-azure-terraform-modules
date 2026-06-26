variable "rg_name" {
  type = map(string)
}

variable "location" {
  type = map(string)
}

variable "subnet_id" {
  type = map(string)
}

variable "app_services" {
  type = map(object({
    app_service_plan_name = string
    app_service_name  = string
    rg_key = string
    subnet_key = string
  }))
}
