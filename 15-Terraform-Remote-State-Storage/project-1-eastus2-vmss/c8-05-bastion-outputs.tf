/*
## Bastion Host Public IP Output
output "bastion_host_linuxvm_public_ip" {
  description  = "bastion host linux vm public ip"
  value  = azurerm_public_ip.Bastion_host_Public_IP.ip_address
}

*/