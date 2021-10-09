# Resource-1: Create Public IP Address
resource "azurerm_public_ip" "Bastion_host_Public_IP" {
  name = "${local.resource_group_prefix}-bastion_host_public_ip"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Static"
  sku = "Standard"
  
}

# Resource-2: Create Network Interface

resource "azurerm_network_interface" "Bastion_host_nic" {
  name = "${local.resource_group_prefix}-bastion_host_nic"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
   
   ip_configuration {
     name = "Bastion-host-ip-1"
     private_ip_address_allocation = "Dynamic"
     public_ip_address_id = azurerm_public_ip.Bastion_host_Public_IP.id
     subnet_id = azurerm_subnet.bastionsubnet.id
   }
  
}


# Resource-3: Azure Linux Virtual Machine - Bastion Host


resource "azurerm_linux_virtual_machine" "Bastion_host_linuxvm-1" {
  name = "${local.resource_group_prefix}-bastion_host_linuxvm"
  computer_name = "Bastion-host-linuxvm-1" 
  admin_username = "azureuser"
  network_interface_ids = [ azurerm_network_interface.Bastion_host_nic.id ]
  size = "Standard_DS1_v2"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  admin_ssh_key {
    username = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }

  os_disk {
    name = "Bastion_host_linux_vm-${random_string.myrandom.id}"
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer = "RHEL"
    sku = "83-gen2"
    version = "latest"
  }
}