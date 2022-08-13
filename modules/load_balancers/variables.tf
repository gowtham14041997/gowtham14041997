#--------------------------------------------------------------------------------
#Public ALB
#----------

variable "public_alb_name" {
  type          = string
  default       = "My-public-ALB"
  description   = "Public ALB name"
}

variable "public_security_group_ids" {
  type          = list(string)
  description   = "Security group for public ALB"
}

variable "public_subnet_ids" {
  type          = list(string)
  description   = "Security group for public ALB"
}

variable "public_target_group_name" {
  type          = string
  default       = "My-public-ALB-target-group"
  description   = "Public ALB target group name"
}

variable "public_target_id" {
  type          = string
  description   = "Public target group ID"
}

#--------------------------------------------------------------------------------
#Private ALB
#-----------

variable "private_alb_name" {
  type          = string
  default       = "My-private-ALB"
  description   = "Private ALB name"
}

variable "private_security_group_ids" {
  type          = list(string)
  description   = "Security group for private ALB"
}

variable "private_subnet_ids" {
  type          = list(string)
  description   = "Security group for private ALB"
}

variable "private_target_group_name" {
  type          = string
  default       = "My-private-ALB-target-group"
  description   = "Private ALB target group name"
}

variable "private_target_id" {
  type          = string
  description   = "Private target group ID"
}

#--------------------------------------------------------------------------------
#Common variables
#----------------

variable "private_alb" {
  type          = bool
  description   = "Boolean to choose between internet-facing and internal load balancer"
}

variable "private__alb" {
  type          = bool
  description   = "Boolean to choose between internet-facing and internal load balancer"
}

variable "elb_type" {
  type          = string
  default       = "application"
  description   = "ELB type"
}

variable "elb_listener_type" {
  type          = string
  default       = "forward"
  description   = "ALB listener type"
}

variable "http_port" {
  type = number
  default    = 80
  description = "HTTP port"	
}

variable "http_protocol" {
  type = string
  default    = "HTTP"
  description = "HTTP protocol"	
}

variable "vpc_id" {
  type          = string
  description   = "VPC ID"
}
