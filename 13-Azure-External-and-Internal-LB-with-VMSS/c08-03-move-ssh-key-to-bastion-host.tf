# Create a Null Resource and Provisioners



resource "null_resource" "copy_file_to_bastion" {
  depends_on = [ azurerm_linux_virtual_machine.Bastion_host_linuxvm-1 ]
  # Connection Block for Provisioners to connect to Azure VM Instance
  connection {
    type = "ssh"
    user = azurerm_linux_virtual_machine.Bastion_host_linuxvm-1.admin_username
    host = azurerm_linux_virtual_machine.Bastion_host_linuxvm-1.public_ip_address
    private_key = file("${path.module}/ssh-keys/terraform-azure.pem")

  } 

  ## File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source = "ssh-keys/terraform-azure.pem"
    destination = "/tmp/terraform-azure.pem"
     
  }
  provisioner "remote-exec" {
    inline = [
        "sudo chmod 400 /tmp/terraform-azure.pem"
    ]
  
  }

}


# Creation Time Provisioners - By default they are created during resource creations (terraform apply)
# Destory Time Provisioners - Will be executed during "terraform destroy" command (when = destroy)