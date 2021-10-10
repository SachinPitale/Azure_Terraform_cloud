---
title: Azure Load Balancer Inbound NAT Rules using Terraform
description: Create Azure Standard Load Balancer Inbound NAT Rules using Terraform
---

## Introduction
- We are going to create Inbound NAT Rule for Standard Load Balancer in this demo
1. azurerm_lb_nat_rule
2. azurerm_network_interface_nat_rule_association
3. Verify the SSH Connectivity to Web Linux VM using Load Balancer Public IP with port 1022



![Alt text](arch/arch.PNG?raw=true "Demo")