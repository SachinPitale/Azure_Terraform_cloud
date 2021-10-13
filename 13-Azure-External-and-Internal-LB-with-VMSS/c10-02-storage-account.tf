# Resource-1: Create Azure Storage account

resource "azurerm_storage_account" "web_storage_account" {
  name = var.storage_account_name
  account_tier  = var.storage_account_tier
  account_kind = var.storage_account_kind
  account_replication_type = var.storage_account_replication_type
  resource_group_name = azurerm_resource_group.rg.name
  location = var.resource_group_location

  static_website {
    index_document = var.static_website_index_document
    error_404_document = var.static_website_error_404_document
  }
  
}


# Resource-2: httpd files Container
resource "azurerm_storage_container" "web_storage_container" {
  name = "web-application-file-container"
  storage_account_name = azurerm_storage_account.web_storage_account.name
  container_access_type = "private"
  
}

# Locals Block with list of files to be uploaded
locals {
  httpd_conf_files = ["app1.conf"]
}

# Resource-3: httpd conf files upload to httpd-files-container

resource "azurerm_storage_blob" "web_page_blob" {
  for_each = local.httpd_conf_files
  name = each.value
  storage_account_name = azurerm_storage_account.web_storage_account.name
  storage_container_name = azurerm_storage_container.web_storage_container.name
  type = "Block"
  source = "${path.module}/app-scipts/${each.value}"
  
}