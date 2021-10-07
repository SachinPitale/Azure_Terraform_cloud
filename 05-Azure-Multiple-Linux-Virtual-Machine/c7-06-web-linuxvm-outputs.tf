## Public IP Address
output "Public_IP_Address" {
  description = "Web Linux VM Public Address"
  value = azurerm_public_ip.web_linuxvm_publicip[*].ip_address
}

# Network Interface Outputs
output "Network_Interface_id" {
  description = "Web Linux VM Network Interface ID"
  value = azurerm_network_interface.web_linuxvm_nic[*].id
}

## Network Interface Private IP Addresses

## Network Interface Private IP Addresses
output "web_linuxvm_network_interface_private_ip_addresses" {
  description = "Web Linux VM Private IP Addresses"
  value = [azurerm_network_interface.web_linuxvm_nic[*].private_ip_addresses]
}

# Linux VM Outputs

## Virtual Machine Public IP
output "web_linuxvm_public_ip_address" {
  description = "Web Linux Virtual Machine Public IP"
  value = azurerm_linux_virtual_machine.web-linux-vm[*].public_ip_address
}


## Virtual Machine Private IP
output "web_linuxvm_private_ip_address" {
  description = "Web Linux Virtual Machine Private IP"
  value = azurerm_linux_virtual_machine.web-linux-vm[*].private_ip_address
}
## Virtual Machine 128-bit ID
output "web_linuxvm_virtual_machine_id_128bit" {
  description = "Web Linux Virtual Machine ID - 128-bit identifier"
  value = azurerm_linux_virtual_machine.web-linux-vm[*].virtual_machine_id
}
## Virtual Machine ID
output "web_linuxvm_virtual_machine_id" {
  description = "Web Linux Virtual Machine ID "
  value = azurerm_linux_virtual_machine.web-linux-vm[*].id
}
