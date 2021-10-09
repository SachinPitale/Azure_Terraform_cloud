# Azure Bastion Service - Resources
## Resource-1: Azure Bastion Subnet

resource "azurerm_subnet" "bastion_service_subnet" {
  name = var.bastion_service_subnet
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.bastion_service_address_prefixes  
}

# Resource-2: Azure Bastion Public IP

resource "azurerm_public_ip" "bastion-service-public-ip" {
  name = "${local.resource_group_prefix}-bastion-service-public-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Static"
  sku = "Standard"
  
}

# Resource-3: Azure Bastion Service Host

resource "azurerm_bastion_host" "bastion-host-service" {
  name = "${local.resource_name_prefix}-bastion-host-service"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  ip_configuration {
    name = "configuration"
    subnet_id = "azurerm_subnet.bastion_service_subnet.id"
    public_ip_address_id = "azurerm_public_ip.bastion-service-public-ip.id"
  }
  
}