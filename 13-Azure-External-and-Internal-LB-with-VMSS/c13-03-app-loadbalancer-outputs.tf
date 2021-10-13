output "app1-lb_public_ip" {
  description = "app loadbalancer public ip"
  value = azurerm_public_ip.slb_app_public_ip.ip_address
  
}

# Load Balancer ID
output "app_lb_id" {
  description = "app loadbalancer id"
  value = azurerm_lb.slb_app.id
  
}

# Load Balancer Frontend IP Configuration Block
output "app_lb_frontend_Ip" {
  description = "app LB frontend_ip_configuration Block"
  value = [azurerm_lb.slb_app.frontend_ip_configuration] 
  
}