# Resource-1: Create Public IP Address for Azure Load Balancer

resource "azurerm_public_ip" "slb_web_public_ip" {
  name = "${local.resource_group_prefix}-slb_web_public_ip_1"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Static"
  sku = "Standard"
  
}

# Resource-2: Create Azure Standard Load Balancer
resource "azurerm_lb" "slb_web" {
  name = "${local.resource_group_prefix}-slb_web"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  sku = "Standard"
  frontend_ip_configuration {
    name = "slb_web_public_ip_1"
    public_ip_address_id = azurerm_public_ip.slb_web_public_ip.id
  }
  
}

# Resource-3: Create LB Backend Pool

resource "azurerm_lb_backend_address_pool" "web1_backend_pool" {
 name = "${local.resource_group_prefix}-web1_backend_pool"
 loadbalancer_id = azurerm_lb.slb_web.id
}

# Resource-4: Create LB Probe
resource "azurerm_lb_probe" "web_1_probe" {
  name = "web-1-probe"
  protocol = "Tcp"
  port = 80
  loadbalancer_id = azurerm_lb.slb_web.id
  resource_group_name = azurerm_resource_group.rg.name
  
}


# Resource-5: Create LB Rule

resource "azurerm_lb_rule" "web_1_rule" {
  name = "web-1-rule"
  backend_address_pool_id = azurerm_lb_backend_address_pool.web1_backend_pool.id
  loadbalancer_id = azurerm_lb.slb_web.id
  frontend_ip_configuration_name = azurerm_lb.slb_web.frontend_ip_configuration[0].name
  frontend_port = 80
  backend_port = 80
  protocol = "Tcp"
  probe_id = azurerm_lb_probe.web_1_probe.id
  resource_group_name = azurerm_resource_group.rg.name
  

}


# Resource-6: Associate Network Interface and Standard Load Balancer

resource "azurerm_network_interface_backend_address_pool_association" "web1_backend_pool_association" {
  for_each = var.web_linuxvm_instance_count
  network_interface_id = azurerm_network_interface.web_linuxvm_nic[each.key].id
  backend_address_pool_id = azurerm_lb_backend_address_pool.web1_backend_pool.id
  ip_configuration_name = azurerm_network_interface.web_linuxvm_nic[each.key].ip_configuration[0].name

}