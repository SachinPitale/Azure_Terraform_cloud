# Add Custom Data for Bastion Host which will install HTTPD related binaries.
# This will install the Apache Bench tool for load testing.
# This Apache Bench helps us to generate huge load on our Application to trigger Scale-Out and Scale-In events for Autoscaling
/*
# Locals Block for custom data
locals {
bastion_custom_data = <<CUSTOM_DATA
#!/bin/sh
#sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd  
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo chmod -R 777 /var/www/html 
sudo echo "Welcome to  - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo "Welcome to - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/app1/hostname.html
sudo echo "Welcome to  - WebVM App1 - App Status Page" > /var/www/html/app1/status.html
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to - WebVM APP-1 </h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
sudo curl -H "Metadata:true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" -o /var/www/html/app1/metadata.html
sudo echo "Welcome to  - Bastion Host - VM Hostname: $(hostname)" > /var/www/html/index.html
CUSTOM_DATA
}





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
  custom_data = base64encode(local.bastion_custom_data)  
}

*/
