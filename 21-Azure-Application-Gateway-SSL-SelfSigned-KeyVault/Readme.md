---
title: Azure Application Gateway SSL with Key Vault
description: Create Azure Application Gateway SSL Self-Signed with Key Vault using Terraform
---
## Introduction
### Important Order of steps to achieve this use-case
1. Create [User-assigned Managed Identity](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview#how-can-i-use-managed-identities-for-azure-resources)
2. Assign the Managed Identity to Application Gateway (identity block in ag)
3. Add a [User-assigned Managed Identity](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview#how-can-i-use-managed-identities-for-azure-resources) to your Key Vault access policy (Resource: azurerm_key_vault_access_policy)
4. Import the SSL certificate into Key Vault and store the certificate SID in a variable
5. Update 443 Listner in AG to access SSL cert from Key Vault
### Important Note
- This approach helps us for real SSL Certificates (Not self-signed) which are managed externally means generating CSR, submit to CA and get Certificate. Those can be imported to Key Vault and referenced in Azure Application Gateway using this approach. 
- Instead of the `httpd.pfx` currently which contains self-signed certificate, in real ssl certificate case `httpd.pfx` will have real ssl certificate and private key, rest all as-is. 




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





