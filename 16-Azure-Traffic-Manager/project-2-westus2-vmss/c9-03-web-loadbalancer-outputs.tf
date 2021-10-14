# LB Public IP

output "web1-lb_public_ip" {
  description = "Web loadbalancer public ip"
  value = azurerm_public_ip.slb_web_public_ip.ip_address
  
}

# Load Balancer ID
output "web_lb_id" {
  description = "Web loadbalancer id"
  value = azurerm_lb.slb_web.id
  
}

# Load Balancer Frontend IP Configuration Block
output "web_lb_frontend_Ip" {
  description = "Web LB frontend_ip_configuration Block"
  value = [azurerm_lb.slb_web.frontend_ip_configuration] 
  
}

output "web_lb_public_ip_address_id" {
  description = "Web Load Balancer Public Address Resource ID"
  value = azurerm_public_ip.slb_web_public_ip.id
}