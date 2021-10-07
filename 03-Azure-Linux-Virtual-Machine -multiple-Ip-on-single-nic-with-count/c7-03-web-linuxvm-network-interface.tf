# Resource-2: Create Network Interface
resource "azurerm_network_interface" "web_linuxvm_nic" {
  
  name = "${local.resource_group_prefix}-web-linuxvm-nic-${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  ip_configuration {
    name = "web1-linuxvm-ip-1"
    private_ip_address_allocation = "Dynamic"
    subnet_id = azurerm_subnet.websubnet.id
    public_ip_address_id = azurerm_public_ip.web_linuxvm_publicip[0].id
  }
  
  ip_configuration {
    name = "web1-linuxvm-ip-2"
    private_ip_address_allocation = "Dynamic"
    subnet_id = azurerm_subnet.websubnet.id
    public_ip_address_id = azurerm_public_ip.web_linuxvm_publicip[1].id
  }

  
}