resource "azurerm_network_interface" "nis" {
  for_each = var.nics
  name                = each.value.network_interface_name
  location            = var.location[each.value.rg_key]
  resource_group_name = var.rg_name[each.value.rg_key]

  ip_configuration {
    name                          = each.value.ip_configuration.name
    subnet_id                     = var.subnet_id[each.value.ip_configuration.subnet_key]
    private_ip_address_allocation = each.value.ip_configuration.private_ip_address_allocation
  }
}

resource "azurerm_virtual_machine" "vms" {
  for_each = var.vms
  name                  = each.value.name
  location              = var.location[each.value.rg_key]
  resource_group_name   = var.rg_name[each.value.rg_key]
  network_interface_ids = [azurerm_network_interface.nis[each.value.nic_key].id]
  vm_size               = each.value.vm_size

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = each.value.computer_name
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}