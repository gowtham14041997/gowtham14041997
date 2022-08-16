#--------------------------------------------------------------------------------
#VPC
#---

resource "aws_vpc" "epam_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.tenancy

  tags = {
    Name = var.vpc_name
  }
}

#--------------------------------------------------------------------------------
#AZs for public and private subnets
#----------------------------------

data "aws_availability_zones" "available_azs" {}

#----------------------------------------------------------------------------------
#Public subnet
#-------------

resource "aws_subnet" "epam_public_subnet" {
  vpc_id            = aws_vpc.epam_vpc.id
  count             = length(var.public_subnet_cidr)
  cidr_block        = element(var.public_subnet_cidr, count.index)
  availability_zone = element(var.subnet_az, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.public_subnet_name} - ${element(var.subnet_az, count.index)}"
  }
}

#----------------------------------------------------------------------------------
#Private subnet
#--------------

resource "aws_subnet" "epam_private_subnet" {
  vpc_id            = aws_vpc.epam_vpc.id
  count             = length(var.private_subnet_cidr)
  cidr_block        = element(var.private_subnet_cidr, count.index)
  availability_zone = element(var.subnet_az, count.index)

  tags = {
    Name = "${var.private_subnet_name} - ${element(var.subnet_az, count.index)}"
  }
}

#----------------------------------------------------------------------------------
#DB subnet
#---------

resource "aws_subnet" "epam_db_subnet" {
  vpc_id            = aws_vpc.epam_vpc.id
  count             = length(var.db_subnet_cidr)
  cidr_block        = element(var.db_subnet_cidr, count.index)
  availability_zone = element(var.subnet_az, count.index)

  tags = {
    Name = "${var.db_subnet_name} - ${element(var.subnet_az, count.index)}"
  }
}