business_divsion = "it"
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


web_vmss_nsg_inbound_port = [22, 80, 443]


ag_subnet_name = "agsubnet"
ag_subnet_address = ["10.20.51.0/24"]


storage_account_name              = "staticwebsite"
storage_account_tier              = "Standard"
storage_account_replication_type  = "LRS"
storage_account_kind              = "StorageV2"
static_website_index_document     = "index.html"
static_website_error_404_document = "error.html"