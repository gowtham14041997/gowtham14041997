#--------------------------------------------------------------------------------
#VPC
#---

variable "vpc_cidr" {
  type          = string
  description   = "VPC CIDR"
}

variable "tenancy" {
  type          = string
  default       = "default"
  description   = "Instance tenancy"
}

variable "vpc_name" {
  type          = string
  default       = "My VPC"
  description   = "VPC name"
}

#--------------------------------------------------------------------------------
#AZs for public, private and DB subnets
#--------------------------------------

variable "subnet_az" {
  type          = list(string)
  description   = "AZs for public and private subnets"
}


#----------------------------------------------------------------------------------
#Public subnet
#-------------

variable "public_subnet_cidr" {
  type          = list(string)
  default       = ["10.0.1.0/24"]
  description   = "public subnet CIDR"
}

variable "public_subnet_name" {
  type          = string
  default       = "My public subnet"
  description   = "public subnet name"
}


#----------------------------------------------------------------------------------
#Private subnet
#--------------

variable "private_subnet_cidr" {
  type          = list(string)
  default       = ["10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
  description   = "private subnet CIDR"
}

variable "private_subnet_name" {
  type          = string
  default       = "My private subnet"
  description   = "private subnet name"
}

#----------------------------------------------------------------------------------
#DB subnet
#---------

variable "db_subnet_cidr" {
  type          = list(string)
  default       = ["10.0.6.0/24", "10.0.7.0/24"]
  description   = "DB subnet CIDR"
}

variable "db_subnet_name" {
  type          = string
  default       = "My DB subnet"
  description   = "DB subnet name"
}