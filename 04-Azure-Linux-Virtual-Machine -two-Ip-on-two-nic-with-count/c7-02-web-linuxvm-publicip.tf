# Resource-1: Create Public IP Address
resource "azurerm_public_ip" "web_linuxvm_publicip" {
  count = 2
  name = "${local.resource_group_prefix}-web-linuxvm-publicip-${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Static"
  domain_name_label = "web1-vm-${count.index}-${random_string.myrandom.id}"
  sku = "Standard"
  
}

