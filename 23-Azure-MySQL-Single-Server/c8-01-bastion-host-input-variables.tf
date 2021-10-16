# Bastion Linux VM Input Variables Placeholder file.

variable "bastion_service_subnet" {
  description = "bastion service subnet name "
  default = "AzureBastionSubnet"

}

variable "bastion_service_address_prefixes" {
  description = "Bastion service address prefixes"
  type =  list(string)
  default = ["10.10.101.0/27"]
  
}
