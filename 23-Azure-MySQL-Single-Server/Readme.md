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

## Additional Reference
- [Use Virtual Network service endpoints and rules for Azure Database for MySQL](https://docs.microsoft.com/en-us/azure/mysql/concepts-data-access-and-security-vnet)