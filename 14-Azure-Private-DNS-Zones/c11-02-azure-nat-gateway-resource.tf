# Resource-1: Create Public IP for Azure NAT Gateway

resource "azurerm_public_ip" "natgw_publicip" {
  name = "natgw-ip"
  allocation_method = "Static"
  sku = "Standard"
  location  = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
}


# Resource-2: Create Azure NAT Gateway

resource "azurerm_nat_gateway" "natgw" {
  name = "${local.resource_group_prefix}-natgw"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "Standard"
  
}


# Resource-3: Associate Azure NAT Gateway and Public IP

resource "azurerm_nat_gateway_public_ip_association" "natgw_pip_associate" {
  nat_gateway_id = azurerm_nat_gateway.natgw.id
  public_ip_address_id = azurerm_public_ip.natgw_publicip.id  
  
}


# Resource-4: Associate AppSubnet and Azure NAT Gateway
resource "azurerm_subnet_nat_gateway_association" "natgw_appsubnet_associate" {
  nat_gateway_id = azurerm_nat_gateway.natgw.id
  subnet_id = azurerm_subnet.appsubnet.id
  
}