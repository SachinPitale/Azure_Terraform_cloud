---
title: Azure Virtual Machine Scale Sets Autoscaling with Terraform
description: Create Azure Virtual Machine Scale Sets Autoscaling with Terraform
---

## Autoscaling Concept 
1. Create VMSS
2. Create Autoscaling Default Profile
  - Percentage CPU Rule
  - Available Memory Bytes Rule
  - LB SYN Count Rule
3. Create Autoscaling Recurrence Profile - Weekdays
4. Create Autoscaling Recurrence Profile - Weekends
5. Create Autoscaling Fixed Profile

```t
Resource: azurerm_monitor_autoscale_setting
- Notification Block
- Profile Block-1: Default Profile
  1. Capacity Block
  2. Percentage CPU Metric Rules
    1. Scale-Up Rule: Increase VMs by 1 when CPU usage is greater than 75%
    2. Scale-In Rule: Decrease VMs by 1when CPU usage is lower than 25%
  3. Available Memory Bytes Metric Rules
    1. Scale-Up Rule: Increase VMs by 1 when Available Memory Bytes is less than 1GB in bytes
    2. Scale-In Rule: Decrease VMs by 1 when Available Memory Bytes is greater than 2GB in bytes
  4. LB SYN Count Metric Rules (JUST FOR firing Scale-Up and Scale-In Events for Testing and also knowing in addition to current VMSS Resource, we can also create Autoscaling rules for VMSS based on other Resource usage like Load Balancer)
    1. Scale-Up Rule: Increase VMs by 1 when LB SYN Count is greater than 10 Connections (Average)
    2. Scale-Up Rule: Decrease VMs by 1 when LB SYN Count is less than 10 Connections (Average)    
```

## Introduction
- VMSS Autoscaling
1. Default Profile
2. Recurrence Profile
3. Fixed Profile
- Each Profile will have following Rules
1. `Percentage CPU` Increase and Decrease Rule
2. `Available Memory Bytes` Increase and Decrease Rule
3. LB `SYN Count` Increase and Decrease Rule


##  Verify Resources
```t
# Other Resources (Untouched)
1. Resource Group 
2. VNETs and Subnets
3. Bastion Host Linux VM

# VMSS Resource
1. Verify the VM Instances in VMSS Resources
2. 2 VM Instances should be created as per Capacity Block from Profile-1: Default Profile
  # Capacity Block     
    capacity {
      default = 2
      minimum = 2
      maximum = 6
    }
3. Verify the Autoscaling Policy in Scaling Tab of VMSS Resource    
```

## Test Scale-Out and Scale-In scenarios
```t
# Connect to Bastion Host Linux VM
ssh -i ssh-keys/terraform-azure.pem azureuser@<Bastion-Host-LinuxVM-PublicIP>
sudo su - 

# Run the Load Test using Apache Bench
ab -k -t 1200 -n 9050000 -c 100 http://<Web-LB-Public-IP>/index.html
ab -k -t 1200 -n 9050000 -c 100 http://52.149.253.66/index.html

# Verify Scale-Out Event
1. Go to -> Virtual Machine Scale Sets -> hr-dev-web-vmss -> Settings -> Instances
2. Go to -> Virtual Machine Scale Sets -> hr-dev-web-vmss -> Settings -> Scaling -> Configure tab -> Open LB Connection Rule
3. Go to -> Virtual Machine Scale Sets -> hr-dev-web-vmss -> Settings -> Scaling -> Run History Tab
4. Scale-Out Observation: A new VM should be created in VM Instances Tab of VMSS 

# Wait for 10 to 15 Minutes
- Wait for 10 to 15 minutes for "Scale-In" Event to Trigger

# Verify Scale-In Event
1. Go to -> Virtual Machine Scale Sets -> hr-dev-web-vmss -> Settings -> Instances
2. Go to -> Virtual Machine Scale Sets -> hr-dev-web-vmss -> Settings -> Scaling -> Configure tab -> Open LB Connection Rule
3. Go to -> Virtual Machine Scale Sets -> hr-dev-web-vmss -> Settings -> Scaling -> Run History Tab
4. Scale-In Observation: 1 VM should be deleted in VM Instances Tab of VMSS and should come down to value present in capacity block (capacity.minimum = 2 VMs)
```

## Architecture
![Alt text](arch/arch.PNG?raw=true "Demo")


## Azure Resource Created by Terraform
![Alt text](arch/resources.PNG?raw=true "Demo")