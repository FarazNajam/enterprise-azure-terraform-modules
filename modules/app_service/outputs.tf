output "default_hostnames" {
  value = {
    for k, app in azurerm_linux_web_app.as :
    k => app.default_hostname
  }
}

output "principal_ids" {
  value = {
    for k, app in azurerm_linux_web_app.as :
    k => app.identity[0].principal_id
  }
}

