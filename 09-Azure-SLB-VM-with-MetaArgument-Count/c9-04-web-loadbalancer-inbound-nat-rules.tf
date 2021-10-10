# Azure LB Inbound NAT Rule
resource "azurerm_lb_nat_rule" "nat_rule_for_webvm" {
  count = var.web_linuxvm_instance_count
  depends_on = [azurerm_linux_virtual_machine.web-linux-vm] 
  name =  "port-${var.lb_inbound_nat_ports[count.index]}-vm-22"
  protocol = "Tcp"
  frontend_port = element(var.lb_inbound_nat_ports, count.index)
  backend_port = 22
  loadbalancer_id = azurerm_lb.slb_web.id
  frontend_ip_configuration_name = azurerm_lb.slb_web.frontend_ip_configuration[0].name
  resource_group_name = azurerm_resource_group.rg.name


}

# Associate LB NAT Rule and VM Network Interface

resource "azurerm_network_interface_nat_rule_association" "web1_nat_rule_association" {
  count = var.web_linuxvm_instance_count
  network_interface_id = element(azurerm_network_interface.web_linuxvm_nic[*].id, count.index)
  ip_configuration_name = element(azurerm_network_interface.web_linuxvm_nic[*].ip_configuration[0].name, count.index)
  nat_rule_id = element(azurerm_lb_nat_rule.nat_rule_for_webvm[*].id, count.index)
  #nat_rule_id = azurerm_lb_nat_rule.nat_rule_for_webvm[count.index].id
  
}