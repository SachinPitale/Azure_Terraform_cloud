---
title: Azure Private DNS Zones using Terraform
description: Create Azure Private DNS Zones using Terraform
---

## Introduction
### Concepts
1. Create Azure Private DNS Zone `terraformguru.com`
2. Register the `Internal LB Static IP` to Private DNS name `applb.terraformguru.com`
3. Update the `app1.conf` which deploys on Web VMSS to Internal LB DNS Name instead of IP Address. 

### Azure Resources
1. azurerm_private_dns_zone
2. azurerm_private_dns_a_record
##  Verify Resources Part-1
- **Important-Note:**  It will take 5 to 10 minutes to provision all the commands outlined in VM Custom Data
```t
# Verify Resources - Virtual Network
1. Azure Resource Group
2. Azure Virtual Network
3. Azure Subnets (Web, App, DB, Bastion)
4. Azure Network Security Groups (Web, App, DB, Bastion)
5. View the topology
6. Verify Terraform Outputs in Terraform CLI

# Verify Resources - Web Linux VMSS 
1. Verify Web Linux VM Scale Sets
2. Verify Virtual Machines in VM Scale Sets
3. Verify Private IPs for Virtual Machines
4. Verify Autoscaling Policy

# Verify Resources - App Linux VMSS 
1. Verify App Linux VM Scale Sets
2. Verify Virtual Machines in VM Scale Sets
3. Verify Private IPs for Virtual Machines
4. Verify Autoscaling Policy


# Verify Resources - Bastion Host
1. Verify Bastion Host VM Public IP
2. Verify Bastion Host VM Network Interface
3. Verify Bastion VM
4. Verify Bastion VM -> Networking -> NSG Rules
5. Verify Bastion VM Topology

# Connect to Bastion Host VM
1. Connect to Bastion Host Linux VM
ssh -i ssh-keys/terraform-azure.pem azureuser@<Bastion-Host-LinuxVM-PublicIP>
sudo su - 
cd /tmp
ls 
2. terraform-azure.pem file should be present in /tmp directory


# 1. Connect to Web Linux VMs in Web VMSS using Bastion Host VM
1. Connect to Web Linux VM
ssh -i ssh-keys/terraform-azure.pem azureuser@<Web-LinuxVM-PrivateIP-1>
ssh -i ssh-keys/terraform-azure.pem azureuser@<Web-LinuxVM-PrivateIP-2>
sudo su - 
cd /var/log
tail -100f cloud-init-output.log
cd /var/www/html
ls -lrt
cd /var/www/html/webvm
ls -lrt
exit
exit

# 2. Connect to App Linux VMs in App VMSS using Bastion Host VM
1. Connect to App Linux VM
ssh -i ssh-keys/terraform-azure.pem azureuser@<App-LinuxVM-PrivateIP-1>
ssh -i ssh-keys/terraform-azure.pem azureuser@<App-LinuxVM-PrivateIP-2>
sudo su - 
cd /var/log
tail -100f cloud-init-output.log
cd /var/www/html
ls -lrt
cd /var/www/html/appvm
ls -lrt
exit
exit

# Web LB: Verify Internet Facing: Standard Load Balancer Resources 
1. Verify Public IP Address for Standard Load Balancer
2. Verify Standard Load Balancer (SLB) Resource
3. Verify SLB - Frontend IP Configuration
4. Verify SLB - Backend Pools
5. Verify SLB - Health Probes
6. Verify SLB - Load Balancing Rules
7. Verify SLB - Insights
8. Verify SLB - Diagnose and Solve Problems

# App LB: Verify Internal Loadbalancer: Standard Load Balancer Resources 
1. Verify Standard Load Balancer (SLB) Resource - Internal LB
2. Verify ISLB - Frontend IP Configuration (IP should be appsubnet IP)
3. Verify ISLB - Backend Pools
4. Verify ISLB - Health Probes
5. Verify ISLB - Load Balancing Rules
6. Verify ISLB - Insights
7. Verify ISLB - Diagnose and Solve Problems
```
## Verify Resources Part-2
- **Important-Note:** It will take 5 to 10 minutes to provision all the commands outlined in VM Custom Data
```t
# Verify Storage Account
1. Verify Storage Account
2. Verify Storage Container
3. Verify app1.conf in Storage Container
4. We are also enabling this container with error pages in that as a static website. That we will use during the Azure Application Gateway usecases. 

# Verify NAT Gateway
1. Verify NAT Gateway 
2. Verify NAT Gateway -> Outbound IP
3. Verify NAT Gateway -> Subnets Associated

# Verify App Linux VM
1. Verify Network Interface created for App Linux VM
2. Verify App Linux VM
3. Verify Network Security Groups associated with VM (App Subnet NSG)
4. View Topology at App Linux VM -> Networking
5. Verify if only private IP associated with App Linux VM
6. Connect to Bastion Host and from there connect to App linux VM

# Connect to Bastion Host
ssh -i ssh-keys/terraform-azure.pem azureuser@<Bastion-Public-IP>
sudo su -
cd /tmp

# Connect to App Linux VM using Bastion Host and Verify Files
- Here App Linux VM will communicate to Internet via NAT Gateway (Outbound Communication) to download and install the "httpd" binary.
ssh -i terraform-azure.pem azureuser@<App-Linux-VM>
sudo su -
cd /var/log
tail -100f /var/log/cloud-init-output.log
cd /var/www/html
ls
cd appvm
ls

# Perform Curl Test on App VM
curl http://<APP-VM-private-IP>
curl http://10.20.11.4

# Sample Output
[root@hr-dev-app-linuxvm ~]# curl http://10.1.11.4
Welcome to - AppVM App1 - VM Hostname: hr-dev-app-linuxvm
[root@hr-dev-app-linuxvm ~]# 

# Exit from App VM
exit
exit

# Verify App LB
1. Verify Standard Load Balancer (SLB) Resource - App LB
3. Verify App SLB - Frontend IP Configuration
4. Verify App SLB - Backend Pools
5. Verify App SLB - Health Probes
6. Verify App SLB - Load Balancing Rules
7. Verify App SLB - Insights
8. Verify App SLB - Diagnose and Solve Problems

# From Bastion Host - perform Curl Test to Azure Internal Standard Load Balancer
curl http://<APP-Loadbalancer-IP>
curl http://10.1.11.241

## Sample Ouptut
[root@hr-dev-bastion-linuxvm tmp]# curl http://10.1.11.241
Welcome to  - AppVM App1 - VM Hostname: hr-dev-app-linuxvm
[root@hr-dev-bastion-linuxvm tmp]# 


# Verify Web Linux VM
ssh -i terraform-azure.pem azureuser@<Web-Linux-VM>
sudo su -
cd /var/log
tail -100f /var/log/cloud-init-output.log # It took 600 seconds for full custom data provisioning
cd /var/www/html
ls
cd webvm
ls
cd /etc/httpd/conf.d
ls  # Verify app1.conf downloaded

# Sample Output at the end of 
  "snapshot": null
}
Cloud-init v. 19.4 running 'modules:final' at Thu, 05 Aug 2021 11:44:05 +0000. Up 32.90 seconds.
Cloud-init v. 19.4 finished at Thu, 05 Aug 2021 11:53:39 +0000. Datasource DataSourceAzure [seed=/dev/sr0].  Up 607.09 seconds
^C
[root@hr-dev-web-linuxvm log]# 

# From Web VM Host - perform Curl Test to Azure Internal Standard Load Balancer
curl http://<APP-Loadbalancer-IP>
curl http://10.20.11.241

# Sample Output
[root@hr-dev-web-linuxvm conf.d]# curl http://10.1.11.241
Welcome to  - AppVM App1 - VM Hostname: hr-dev-app-linuxvm
[root@hr-dev-web-linuxvm conf.d]# 

# From Web VM Host - perform Curl Test using Web VM Private IP
curl http://<Web-VM-Private-IP>
curl http://10.20.1.4

# Sample Output
[root@hr-dev-web-linuxvm conf.d]# curl http://10.1.1.4
Welcome to  - AppVM App1 - VM Hostname: hr-dev-app-linuxvm
[root@hr-dev-web-linuxvm conf.d]# 

# Access Application using Internet facing Azure Standard Load Balancer Public
## Web VM Files
http://<LB-Public-IP>/webvm/index.html # Should be served from web Linux VM
http://<LB-Public-IP>/webvm/metadata.html

## App VM Files
http://<LB-Public-IP>/ # index.html should be served from App Linux VM
http://<LB-Public-IP>/appvm/index.html # Should be served from app Linux VM
http://<LB-Public-IP>/appvm/metadata.html
```


##  Reverse Proxy Outbound open on RedHat VM Apache2
```t


## Architecture
![Alt text](arch/arch.PNG?raw=true "Demo")


## Azure Resource Created by Terraform
![Alt text](arch/resources.PNG?raw=true "Demo")