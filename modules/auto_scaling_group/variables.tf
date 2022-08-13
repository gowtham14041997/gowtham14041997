#--------------------------------------------------------------------------------
#Public launch template
#----------------------

variable "public_launch_template_name" {
  type          = string
  default       = "My_public_instance_launch_template"
  description   = "Public launch template name"
}

variable "public_instance_name" {
  type          = string
  default       = "My public instance"
  description   = "Public instances name"
}

variable "public_instance_ami" {
  type          = string
  description   = "AMI of public EC2 instances"
}

variable "public_instance_type" {
  type          = string
  description   = "Public EC2 instance type"
}

variable "public_associate_public_ip" {
  type          = bool
  description   = "Boolean value to associate public IP addresses to public instances"
}

variable "public_security_group_id" {
  type          = list(string)
  description   = "Security group IDs to associate with public instances"
}

#--------------------------------------------------------------------------------
#Public autoscaling group
#------------------------

variable "public_asg_name" {
  type          = string
  default       = "My public ASG"
  description   = "Public autoscaling group name"
}

variable "public_subnet_ids" {
  type          = list(string)
  description   = "Public subnets to launch EC2 instances"
}

variable "public_target_group_arn" {
  type          = list(string)
  description   = "Public ALB target group arn"
}

#--------------------------------------------------------------------------------
#Private launch template
#-----------------------

variable "private_launch_template_name" {
  type          = string
  default       = "My_private_instance_launch_template"
  description   = "Private launch template name"
}

variable "private_instance_name" {
  type          = string
  default       = "My private instance"
  description   = "Private instances name"
}

variable "private_instance_ami" {
  type          = string
  description   = "AMI of private EC2 instances"
}

variable "private_instance_type" {
  type          = string
  description   = "Private EC2 instance type"
}

variable "private_associate_public_ip" {
  type          = bool
  description   = "Boolean value to associate public IP addresses to private instances"
}

variable "private_security_group_id" {
  type          = list(string)
  description   = "Security group IDs to associate with private instances"
}

variable "private_subnet_key" {
  type          = string
  default       = "My private instance key"
  description   = "Private instance key pair"
}

variable "public_key" {
  type          = string
  default       = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCKL0VOx5se/OClRd83X4+pZgHRdA7ET7o9LZIAepGIaJBWo/FZiLQ76wzXv2NT0CEMS1q5OMvwb8mOC6ab9BJcKWVnxWMdvLiiBYmnfdtFtpg3S31vTt03berIwml7cAfviU/aZsVzyNyKqrhLLtLNCgsq/zWMwjXdVek9J6QOev7OLie2UnXRn0TpJesMxlObzwQ6Dps6ANI4j0uewxGO2m/kkEqwnkAuw8pv3dfqMomVjhmXAdCerxceKFUXrh7BmEIB5q4/h68wgz25iu6b/tp8D8xCvdqs/PQ99LEd8fdb5k/F7UQW+3SUIjqbd5zjWFBa3p63zvm2sJ1BNKwn"
  description   = "Public key of private instances to SSH"
}

#--------------------------------------------------------------------------------
#Private autoscaling group
#------------------------

variable "private_asg_name" {
  type          = string
  default       = "My private ASG"
  description   = "Private autoscaling group name"
}

variable "private_subnet_ids" {
  type          = list(string)
  description   = "Private subnets to launch EC2 instances"
}

variable "private_target_group_arn" {
  type          = list(string)
  description   = "Private ALB target group arn"
}

#--------------------------------------------------------------------------------
#Bastion host
#------------

variable "bastion_host_name" {
  type          = string
  default       = "My bastion host"
  description   = "Bastion hosts name"
}

variable "bastion_security_group_id" {
  type          = list(string)
  description   = "Security group ID to associate with bastion host"
}

variable "bastion_host_key" {
  type          = string
  default       = "My bastion host key"
  description   = "Bastion host key pair"
}

variable "bastion_public_key" {
  type          = string
  default       = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCRUcUfjzvjJdDNZ5yBVldrffQAnLFtLweywwc940jH5fWJ3NztgG/nvlFJKDc/qpn2idC6BFB1NK7jvNucBDY3sC1+PrJlT2xywf/DmpCUjnMz/AEyBSfwZvICgKfKTE6rXx2VqAE6rURggXjY1gwyNWxIIvcrOu0mrd+Ctf3nvSKou2bF6/9xk0HZ88kq4gwuarDwqHBIuyuM6glfMjcgl9rxhFQLW+GVolGPdBN4pPNXCUeEzRNwooIVOkQlQCpSpMbwLyZS+c5ohfLp6zlYGk57BX/614s8BS7z6w+s2qwOhbRyhrOx7ffTWmtYqMwLatuwD9Lms3vpMmOmJKL5"
  description   = "Public key of bastion hosts to SSH"
}

variable "bastion_subnet_id" {
  type          = string
  description   = "Subnet ID for bastion host"
}

#--------------------------------------------------------------------------------
#Common variables
#----------------

variable "resource_type" {
  type          = string
  default       = "instance"
  description   = "Type of resource in launch template"
}

variable "health_check_type" {
  type          = string
  default       = "ELB"
  description   = "Health check type for EC2 instances in VPC"
}

variable "min_instance_count" {
  type          = number
  description   = "Minimum number of EC2 instances in ASG"
}

variable "desired_instance_count" {
  type          = number
  description   = "Desired number of EC2 instances in ASG"
}

variable "max_instance_count" {
  type          = number
  description   = "Maximum number of EC2 instances in ASG"
}