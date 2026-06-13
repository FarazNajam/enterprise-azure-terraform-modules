output "subnet_id" {
  value = {
    for k, s in azurerm_subnet.subnets :
    k => s.id
  }
}