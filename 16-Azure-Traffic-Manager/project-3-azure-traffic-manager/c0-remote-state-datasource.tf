# Project-1: East US2 Datasource

data "terraform_remote_state" "project1_eastus2" {
  backend = "azurerm"
  config  = {
    resource_group_name = "terraform-backend-rg"
    storage_account_name = "terraformdevpipeline"
    container_name       = "tfstatefiles"
    key = "project-1-eastus2-terraform.tfstate"
  }    
  
}


# Project-2: West US2 Datasource
data "terraform_remote_state" "project2_westus2" {
  backend = "azurerm"
  config  = {
    resource_group_name = "terraform-backend-rg"
    storage_account_name = "terraformdevpipeline"
    container_name       = "tfstatefiles"
    key = "project-2-westus2-terraform.tfstate"
  }    
  
}

