# FQDN Outputs
output "fqdn_app_lb" {
  description = "App LB FQDN"
  value = azurerm_private_dns_a_record.app_slb_dns_a_record.fqdn
}