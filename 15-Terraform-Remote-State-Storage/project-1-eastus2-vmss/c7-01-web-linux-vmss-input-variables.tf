# Linux VM Input Variables Placeholder file.

variable "web_vmss_nsg_inbound_port" {
  description = "web vmss nsg inbound port on nic level"
  type = list(string)
  default = [ 22, 80, 443 ]
  
}