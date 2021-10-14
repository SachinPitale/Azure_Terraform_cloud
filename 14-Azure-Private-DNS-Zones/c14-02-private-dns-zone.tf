# Resource-1: Create Azure Private DNS Zone

resource "azurerm_private_dns_zone" "private_dns_zone" {
  name = var.private_dns_zone_name
  resource_group_name = azurerm_resource_group.rg.name
  
}


# Resource-2: Associate Private DNS Zone to Virtual Network

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_association" {
  name = "${local.resource_group_prefix}-private-dns-assosication"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  resource_group_name =  azurerm_resource_group.rg.name
  virtual_network_id = azurerm_virtual_network.vnet.id 
}


# Resource-3: Internal Load Balancer DNS A Record

resource "azurerm_private_dns_a_record" "app_slb_dns_a_record" {
  name = var.app_slb_dns_a_record_name
  zone_name = azurerm_private_dns_zone.private_dns_zone.name
  resource_group_name =  azurerm_resource_group.rg.name
  ttl = 300
  records = ["${azurerm_lb.slb_app.frontend_ip_configuration[0].private_ip_address}"]
  
}