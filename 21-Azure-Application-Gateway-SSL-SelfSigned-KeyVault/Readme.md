---
title: Azure Application Gateway SSL with Key Vault
description: Create Azure Application Gateway SSL Self-Signed with Key Vault using Terraform
---
## Step-00: Introduction
### Important Order of steps to achieve this use-case
1. Create [User-assigned Managed Identity](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview#how-can-i-use-managed-identities-for-azure-resources)
2. Assign the Managed Identity to Application Gateway (identity block in ag)
3. Add a [User-assigned Managed Identity](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview#how-can-i-use-managed-identities-for-azure-resources) to your Key Vault access policy (Resource: azurerm_key_vault_access_policy)
4. Import the SSL certificate into Key Vault and store the certificate SID in a variable
5. Update 443 Listner in AG to access SSL cert from Key Vault
### Important Note
- This approach helps us for real SSL Certificates (Not self-signed) which are managed externally means generating CSR, submit to CA and get Certificate. Those can be imported to Key Vault and referenced in Azure Application Gateway using this approach. 
- Instead of the `httpd.pfx` currently which contains self-signed certificate, in real ssl certificate case `httpd.pfx` will have real ssl certificate and private key, rest all as-is. 
