#--------------------------------------------------------------------------------
#Public security group
#---------------------

resource "aws_security_group" "epam_public_security_group" {
  name        = var.public_security_group
  description = var.public_security_group_description
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = var.tcp_protocol
    cidr_blocks = var.allow_all_ipv4_cidr
  }

  egress {
    from_port     = var.egress_rules_port
    to_port       = var.egress_rules_port
    protocol      = var.egress_rules_protocol
    cidr_blocks   = var.allow_all_ipv4_cidr
  }

  tags = {
    Name = var.public_security_group_name
  }
}

#--------------------------------------------------------------------------------
#Private security group
#----------------------

resource "aws_security_group" "epam_private_security_group" {
  name        = var.private_security_group
  description = var.private_security_group_description
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.tcp_protocol
    cidr_blocks = ["${var.bastion_private_ip}/32"]
  }

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = var.tcp_protocol
    cidr_blocks = var.private_ingress_http_cidr
  }

  egress {
    from_port     = var.egress_rules_port
    to_port       = var.egress_rules_port
    protocol      = var.egress_rules_protocol
    cidr_blocks   = var.allow_all_ipv4_cidr
  }

  tags = {
    Name = var.private_security_group_name
  }
}

#--------------------------------------------------------------------------------
#Public IP that can access bastion hosts
#---------------------------------------

data "aws_instance" "master_instance" {
    filter {
        name = "tag:Name"
        values = ["master-terraform"]
    }  
}

#--------------------------------------------------------------------------------
#Bastion security group
#----------------------

resource "aws_security_group" "epam_bastion_security_group" {
  name        = var.bastion_security_group
  description = var.bastion_security_group_description
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.tcp_protocol
    cidr_blocks = ["${data.aws_instance.master_instance.public_ip}/32"]
  }

  egress {
    from_port     = var.egress_rules_port
    to_port       = var.egress_rules_port
    protocol      = var.egress_rules_protocol
    cidr_blocks   = var.allow_all_ipv4_cidr
  }
  
  tags = {
    Name = var.bastion_security_group_name
  }
}