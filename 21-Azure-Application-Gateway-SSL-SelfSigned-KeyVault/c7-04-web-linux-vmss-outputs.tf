# VM Scale Set Outputs

output "web_vmss_id" {
  description = "web vmss scale set id"
  value = azurerm_linux_virtual_machine_scale_set.web_vmss.id
  
}
