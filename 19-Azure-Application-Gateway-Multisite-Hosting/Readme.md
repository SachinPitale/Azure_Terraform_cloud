---
title: Azure Application Gateway Multisite Hosting
description: Create Azure Application Gateway Multisite Hosting using Terraform
---
## Step-00: Introduction
1. Update Locals Block to support Multiple Listeners and Routing Rules for Multisite Hosting
2. Create Two Listeners for App1 and App2
3. Create Two Routing Rules for App1 and App2





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
5. AG Listeners (App1 and App2 Listeners for Multisite Hosting)
6. AG Rules + Verify Routing Rules App1 and App2
7. AG Health Probes
8. AG Insights
```

## Add Host Entries and Test
```t
# Add Host Entries
## Linux or MacOs
sudo vi /etc/hosts

### Host Entry Template
<AG-Public-IP>  app1.terraformguru.com
<AG-Public-IP>  app2.terraformguru.com

### Host Entry Template - Replace AG-Public-IP
52.146.71.48 app1.terraformguru.com
52.146.71.48  app2.terraformguru.com

# Access Application - app1.terraformguru.com
http://app1.terraformguru.com/index.html
http://app1.terraformguru.com/app1/index.html
http://app1.terraformguru.com/app1/metadata.html
http://app1.terraformguru.com/app1/status.html
http://app1.terraformguru.com/app1/hostname.html

# Access Application - app2.terraformguru.com
http://app2.terraformguru.com/index.html
http://app2.terraformguru.com/app2/index.html
http://app2.terraformguru.com/app2/metadata.html
http://app2.terraformguru.com/app2/status.html
http://app2.terraformguru.com/app2/hostname.html

# Remove / Comment Host Entries after testing 
## Linux or MacOs
sudo vi /etc/hosts
#52.146.71.48 app1.terraformguru.com
#52.146.71.48  app2.terraformguru.com
```


## Architecture
![Alt text](arch/arch.PNG?raw=true "Demo")





## Azure Resource Created by Terraform
![Alt text](arch/resources.PNG?raw=true "Demo")




