
## Bastion Host Public IP Output
output "bastion_host_linuxvm_public_ip" {
  description  = "bastion host linux vm public ip"
  value  = azurerm_linux_virtual_machine.Bastion_host_Public_IP.ip_address
}