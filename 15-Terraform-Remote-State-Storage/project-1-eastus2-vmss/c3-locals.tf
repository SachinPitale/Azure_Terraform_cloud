# Define Local Values in Terraform

locals {
  owners = var.business_divsion
  environment = var.environment
  #resource_group_prefix = "${var.business_divsion}-${var.environment}"
  resource_group_prefix = "${var.business_divsion}-${var.business_divsion}-${var.environment}"
  common_tags = {
      owners = local.owners
      environment = local.environment
  }
}