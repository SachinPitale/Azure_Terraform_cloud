---
title: Azure Traffic Manager using Terraform
description: Create Azure Traffic Manager using Terraform
---
## Step-01: Introduction
- Understand about [Terraform Remote State Datasource](https://www.terraform.io/docs/language/state/remote-state-data.html)
- Terraform Remote State Storage Demo with two projects

##  Project-1: Execute Terraform Commands
```t
# Change Directory 
cd project-1-eastus2-vmss

# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve

# Observation
1. Verify all resources in eastus2 region
2. Verify Storage Account - TFState file
```


## Project-2: Execute Terraform Commands
```t
# Change Directory 
cd project-2-westus2-vmss

# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve

# Observation
1. Verify all resources in westus2 region
2. Verify Storage Account - TFState file
```


## Project-3: Execute Terraform Commands
```t
# Change Directory 
cd project-3-azure-traffic-manager

# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve

# Observation
1. Verify Azure Traffic Manager Resources
2. Verify Storage Account - TFState file

# Access Apps from both regions eastus2 and westus2
http://<Traffic-Manager-DNS-Name>
```