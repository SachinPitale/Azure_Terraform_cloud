business_divsion = "IT"
environment = "dev"
resource_group_name = "rg"
resource_group_location = "eastus"

vnet_name = "vnet"
vnet_address_space = ["10.20.0.0/16"]

web_subnet_name = "websubnet"
web_subnet_address = ["10.20.1.0/24"]

app_subnet_name = "appsubnet"
app_subnet_address = ["10.20.11.0/24"]

db_subnet_name = "dbsubnet"
db_subnet_address = ["10.20.21.0/24"]

bastion_subnet_name = "bastionsubnet"
bastion_subnet_address = ["10.20.100.0/24"]

bastion_service_subnet = "AzureBastionSubnet"
bastion_service_address_prefixes = ["10.20.101.0/27"]