---
title: Azure Bastion Host and Service using Terraform
description: Create Azure Bastion Host and Service using Terraform
---

## Introduction
- We are going to create two important Bastion Resources 
1. Azure Bastion Host 
2. Azure Bastion Service 
- We are going to use following Azure Resources for the same.
1. Terraform Input Variables
2. azurerm_public_ip
3. azurerm_network_interface
4. azurerm_linux_virtual_machine
5. Terraform Null Resource `null_resource`
6. Terraform File Provisioner
7. Terraform remote-exec Provisioner
8. azurerm_bastion_host
9. Terraform Output Values



#![Alt text](arch/arch.PNG?raw=true "Demo")