# Terraform Block
terraform {
  required_version = ">= 1.0"
  required_providers {
      azurerm = {
          source = "hashicorp/azurerm"
          version = ">= 2.0"
      }
      random = {
          source = "hashicorp/random"
          version = ">= 3.0"
  }
  } 
  backend "azurerm" {
    resource_group_name = "terraform-backend-rg"
    storage_account_name = "terraformdevpipeline"
    container_name       = "tfstatefiles"
    key = "project-1-eastus2-terraform.tfstate"
  } 
}

# Terraform State Storage to Azure Storage Container


# Provider Block
provider "azurerm" {
  features {} 
}


