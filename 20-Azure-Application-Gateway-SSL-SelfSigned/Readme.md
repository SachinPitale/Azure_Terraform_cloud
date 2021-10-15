---
title: Azure Application Gateway SSL using Terraform
description: Create Azure Application Gateway SSL Self-Signed using Terraform
---
##  Introduction
0. Leverage `Section-27-Azure-Application-Gateway-Basics` and build on top of them all the below features
1. HTTP 80 Listener
2. HTTP 443 Listener
3. HTTP to HTTPS Redirect
4. Custom Error Pages for Application Gateway hosted on Azure Storage Account Static Website
5. Self Signed SSL Certificate - 20 years validity



##  Generate Self Signed SSL
```t
# Change to Directory
cd ssl-self-signed

# Generate Self Signed Certificate and Private Key
openssl req -newkey rsa:2048 -nodes -keyout httpd.key -x509 -days 7300 -out httpd.crt
```

## Step-02: Convert SSL Certificate, Key to PFX
```t
# Change to Directory
cd ssl-self-signed

# Generate PFX file
openssl pkcs12 -export -out httpd.pfx -inkey httpd.key -in httpd.crt -passout pass:sachin

# Verify File
ls -lrta httpd.pfx
```

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

##  Verify Resources
```t
# Azure Virtual Network Resources
1. Azure Virtual Network
2. Web, App, DB, Bastion and AG Subnets

# Azure Web VMSS
1. Azure VMSS
2. Azure VMSS Instances
3. Azure VMSS Autoscaling
4. Azure VMSS Topology

# Azure Application Gateway
1. AG Configuration Tab
2. AG Backend Pools
3. AG HTTP Settings
4. AG Frontend IP
5. AG SSL Settings (NONE)
6. AG Listeners
7. AG Rules
8. AG Health Probes
9. AG Insights

```

## Step-15: Add Host Entries and Test
- Test in Firefox browser which allows the SSL exception for Self-Signed Certificates
```t
# Add Host Entries
## Linux or MacOs
sudo vi /etc/hosts

### Host Entry Template
<AG-Public-IP>  terraformguru.com

### Host Entry Template - Replace AG-Public-IP
20.185.210.71   terraformguru.com

# Test HTTP to HTTPS Redirect
http://terraformguru.com/index.html
http://terraformguru.com/app1/index.html
http://terraformguru.com/app1/metadata.html
http://terraformguru.com/app1/status.html
http://terraformguru.com/app1/hostname.html
Observation: All these should auto-redirect from HTTP to HTTPS

# Test Error Pages
1. Stop VMSS Virtual Machine Instances
2. Wait for few minutes
http://terraformguru.com/index.html
http://terraformguru.com/app1/index.html
Observation: Static error pages hosted in Static Website should be displayed 

# Access Static Error Pgaes via Static Website Endpoint
http://<STATIC-WEBSITE-ENDPOINT>/502.html
http://<STATIC-WEBSITE-ENDPOINT>/403.html


# Remove / Comment Host Entries after testing 
## Linux or MacOs
sudo vi /etc/hosts
#20.185.210.71  app1.terraformguru.com
```
## Architecture
![Alt text](arch/arch.PNG?raw=true "Demo")

## Azure Resource Created by Terraform
![Alt text](arch/resources.PNG?raw=true "Demo")





