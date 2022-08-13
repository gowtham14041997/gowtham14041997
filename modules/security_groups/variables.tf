#--------------------------------------------------------------------------------
#Public security group
#---------------------

variable "public_security_group" {
  type          = string
  default       = "EPAM public security group"
  description   = "EPAM public security group"
}

variable "public_security_group_name" {
  type          = string
  default       = "My public security group"
  description   = "Public security group name"
}

variable "public_security_group_description" {
  type          = string
  default       = "Security group for public instances"
  description   = "Public security group description"
}

#--------------------------------------------------------------------------------
#Private security group
#----------------------

variable "private_security_group" {
  type          = string
  default       = "EPAM private security group"
  description   = "EPAM private security group"
}

variable "private_security_group_name" {
  type          = string
  default       = "My private security group"
  description   = "Private security group name"
}

variable "private_security_group_description" {
  type          = string
  default       = "Security group for private instances"
  description   = "Public security group description"
}

variable "bastion_private_ip" {
  type          = string
  description   = "Private IP of bastion host"
}

variable "private_ingress_http_cidr" {
  type          = list(string)
  description   = "Private security group ingress http cidr"
}

#--------------------------------------------------------------------------------
#Bastion security group
#----------------------

variable "bastion_security_group" {
  type          = string
  default       = "EPAM bastion security group"
  description   = "EPAM bastion security group"
}

variable "bastion_security_group_name" {
  type          = string
  default       = "My bastion security group"
  description   = "Bastion security group name"
}

variable "bastion_security_group_description" {
  type          = string
  default       = "Security group for bastion hosts"
  description   = "Bastion security group description"
}

#--------------------------------------------------------------------------------
#Common variables
#----------------

variable "vpc_id" {
  type          = string
  description   = "VPC ID"
}

variable "egress_rules_port" {
  type = number
  default = 0
  description = "Security group egress rules port"	
}

variable "egress_rules_protocol" {
  type = string
  default = "-1"
  description = "Security group egress rules protocol"	
}

variable "allow_all_ipv4_cidr" {
  type          = list(string)
  default       = ["0.0.0.0/0"]
  description   = "Allow all IPv4 addresses"
}

variable "ssh_port" {
  type = number
  default    = 22
  description = "SSH port"	
}

variable "http_port" {
  type = number
  default    = 80
  description = "HTTP port"	
}

variable "tcp_protocol" {
  type = string
  default    = "tcp"
  description = "TCP protocol"	
}