---
title: Terraform Remote State Storage & Locking
description: Learn about Terraform Remote State Storage & Locking
---

##  Create Azure Storage Account
###  Create Resource Group
- Go to Resource Groups -> Add 
- **Resource Group:** terraform-backend-rg 
- **Region:** East US
- Click on **Review + Create**
- Click on **Create**


###  Create Azure Storage Account
- Go to Storage Accounts -> Add
- **Resource Group:** terraform-backend-rg 
- **Storage Account Name:** terraformdevpipeline (THIS NAME SHOULD BE UNIQUE ACROSS AZURE CLOUD)
- **Region:** East US
- **Performance:** Standard
- **Redundancy:** Geo-Redundant Storage (GRS)
- In `Data Protection`, check the option `Enable versioning for blobs`
- REST ALL leave to defaults
- Click on **Review + Create**
- Click on **Create**

###  Create Container in Azure Storage Account
- Go to Storage Account -> `terraformdevpipeline` -> Containers -> `+Container`
- **Name:** tfstatefiles
- **Public Access Level:** Private (no anonymous access)
- Click on **Create**
