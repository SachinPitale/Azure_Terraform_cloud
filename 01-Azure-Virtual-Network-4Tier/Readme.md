---
title: Azure Virtual Network Design using Terraform
description: Design 4-Tier Azure Virtual Network using Terraform
---

### Azure Virtual Network Design
- We are going to design the 4-Tier Azure Virtual Network here
1. Azure Virtual Network
2. WebTier Subnet + WebTier Network Security Group (Ports 80, 443)
3. AppTier Subnet + AppTier Network Security Group (Ports 8080, 80, 443)
4. DBTier Subnet + DBTier Network Security Group  (Ports 3306, 1433, 5432)
5. Bastion Subnet + Bastion Network Security Group (Ports 80, 3389)
6. Terraform `for_each` Meta-Argument 
### Azure Resources created
1. azurerm_resource_group
2. azurerm_virtual_network
3. azurerm_subnet
4. azurerm_network_security_group
5. azurerm_subnet_network_security_group_association
6. azurerm_network_security_rule



![Alt text](arch/arch.PNG?raw=true "Demo")