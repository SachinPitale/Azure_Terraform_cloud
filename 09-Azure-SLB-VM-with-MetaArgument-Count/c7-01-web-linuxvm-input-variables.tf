# Linux VM Input Variables Placeholder file.

variable "web_linuxvm_instance_count" {
  description = "Web Linux VM Instance Count"
  type = Number
  default = 1
  
}

# Web LB Inbout NAT Port for All VMs

variable "lb_inbound_nat_ports" {
  description = "Web LB Inbound NAT Ports List"
  type = list(string)
  value = ["1022", "2022", "3022", "4022", "5022"]
}