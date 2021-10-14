# VM Scale Set Outputs

output "app_vmss_id" {
  description = "app vmss scale set id"
  value = azurerm_linux_virtual_machine_scale_set.app_vmss.id
  
}
