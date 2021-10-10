# Azure LB Inbound NAT Rule
resource "azurerm_lb_nat_rule" "nat_rule_for_webvm" {
  depends_on = [azurerm_linux_virtual_machine.web-linux-vm] 
  name = "port-1022-vm-22"
  protocol = "Tcp"
  frontend_port = 1022
  backend_port = 22
  loadbalancer_id = azurerm_lb.slb_web.id
  frontend_ip_configuration_name = azurerm_lb.slb_web.frontend_ip_configuration[0].name
  resource_group_name = azurerm_resource_group.rg.name


}

# Associate LB NAT Rule and VM Network Interface

resource "azurerm_network_interface_nat_rule_association" "web1_nat_rule_association" {
  network_interface_id = azurerm_network_interface.web_linuxvm_nic.id
  ip_configuration_name = azurerm_network_interface.web_linuxvm_nic.ip_configuration[0].name
  nat_rule_id = azurerm_lb_nat_rule.nat_rule_for_webvm.id
  
}