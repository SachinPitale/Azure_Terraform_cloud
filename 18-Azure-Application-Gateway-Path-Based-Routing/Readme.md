---
title: Azure Application Gateway Path based Routing
description: Create Azure Application Gateway Path based Routing using Terraform
---
## Step-00: Introduction
1. Context Path based Routing
  - /app1/* -> App1 VMSS
  - /app2/* -> App2 VMSS
2. Root Context Redirection to some external site
  - /*      -> External Site `portal.azure.com`


##  Execute Terraform Commands
```t
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve
```


## Verify Resources
```t
# Verify VNET Resources
1. Verify VNET
2. Verify Subnets
3. Verify NSG

# Verify VMSS Resources
1. Verify App1 VMSS
2. Verify App2 VMSS

# Azure Application Gateway
1. AG Configuration Tab
2. AG Backend Pools
3. AG HTTP Settings
4. AG Frontend IP
5. AG Listeners
6. AG Rules + Verify Routing Rules App1 and App2
7. AG Health Probes
8. AG Insights

# Access Application - App1 /app1/*
http://<AG-Public-IP>/app1/index.html
http://<AG-Public-IP>/app1/metadata.html
http://<AG-Public-IP>/app1/status.html
http://<AG-Public-IP>/app1/hostname.html

# Access Application - App2 /app2/*
http://<AG-Public-IP>/app2/index.html
http://<AG-Public-IP>/app2/metadata.html
http://<AG-Public-IP>/app2/status.html
http://<AG-Public-IP>/app2/hostname.html

# Access Application - Default Root Context /*
http://<AG-Public-IP>
```


## Architecture
![Alt text](arch/arch.PNG?raw=true "Demo")





## Azure Resource Created by Terraform
![Alt text](arch/resources.PNG?raw=true "Demo")


!



