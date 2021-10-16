---
title: Azure MySQL Single Server using Terraform
description: Create Azure MySQL Single Server using Terraform
---

### Terraform Concepts
1. Input Variables `mysqldb.auto.tfvars`
2. Input Variables `secrets.tfvars` with `-var-file` argument

### Azure Concepts 
1. Create Azure MySQL Single Server and Sample Schema in it
2. Create `service endpoint policies` to allow traffic to specific azure resources from your virtual network over service endpoints
3. Create `Virtual Network Rule` to make a connection from Azure Virtual Network Subnet to Azure MySQL Single Server 
4. Create a `MySQL Firewall Rule` to allow Bastion Host to access MySQL DB. Understand MySQL Firewall rule concept. 

### Azure Resources
1. azurerm_mysql_server
2. azurerm_mysql_database
3. azurerm_mysql_firewall_rule
4. azurerm_mysql_virtual_network_rule



## Connect to MySQL DB from Bastion Host VM and VMSS VM
- Test from Bastion Host which confirms our Azure MySQL firewall rule test
- Test from VMSS VM1 or VM2 confirms that our `Azure MySQL Virtual Network rule` and `Web Subnet Service Endpoint Configs` we have enabled private communication from `Web Subnet hosted VM's to Azure MySQL Single Server`
```t
# SSH to Bastion Host
ssh -i ssh-keys/terraform-azure.pem azureuser@<Bastion-Public-IP>
sudo su - 

# Connect to MySQL DB
mysql -h it-dev-mysql.mysql.database.azure.com -u dbadmin@it-dev-mysql -p 

# DB Password to use
mysql_db_password = "H@Sh1CoR3!"

# SSH to Web VMSS VM1 or VM2
ssh -i /tmp/terraform-azure.pem azureuser@<VMSS-VM1-Private-IP>
ssh -i /tmp/terraform-azure.pem azureuser@10.1.1.6

# Connect to MySQL DB from Web VMSS VM1 or VM2 (This happens via Virtual Network we created from Web Subnet to MySQL Server)
mysql -h it-dev-mysql.mysql.database.azure.com -u dbadmin@it-dev-mysql -p 
```

## Additional Reference
- [Use Virtual Network service endpoints and rules for Azure Database for MySQL](https://docs.microsoft.com/en-us/azure/mysql/concepts-data-access-and-security-vnet)