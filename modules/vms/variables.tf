variable "rg_name" {
  type = map(string)
}

variable "location" {
  type = map(string)
}

variable "nics" {
  type = map(object({
    network_interface_name = string
    ip_configuration_name = string
    subnet_key = string
    rg_key = string
    private_ip_address_allocation = string
  }))
}

variable "vms" {
  type = map(object({
    name = string
    nic_key = string
    rg_key = string
    vm_size = string
    computer_name = string
    admin_username = string
    admin_password = string
  }))
}