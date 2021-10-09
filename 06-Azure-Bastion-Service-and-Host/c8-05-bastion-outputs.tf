
## Bastion Host Public IP Output
output "bastion_host_linuxvm_public_ip" {
  value = "bastion host linux vm public ip"
  default = azurerm_linux_virtual_machine.Bastion_host_linuxvm-1.ip_address
}