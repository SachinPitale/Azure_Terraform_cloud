
# Create Network Security Group using Terraform Dynamic Blocks
resource "azurerm_network_security_group" "app1_web_vmss_nsg" {
  name = "${local.resource_group_prefix}-app1_web_vmss_nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
   
  dynamic "security_rule" {
    for_each = var.app1_web_vmss_nsg_inbound_ports
    content {
      name                       = "Allow_port_for-${security_rule.value}"
      description                = "Inbound Rule ${security_rule.key}" 
      priority                   = sum([100, security_rule.key])
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

  }

  
}