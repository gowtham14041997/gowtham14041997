provider "aws" {
  profile    = "gowtham"
  region     = var.region
}

module "my_vpc" {
  source                = "../modules/vpc"

  #VPC
  vpc_cidr              = "10.0.0.0/16"

  #Public subnet CIDR for web-servers
  public_subnet_cidr    = ["10.0.1.0/24", "10.0.2.0/24"]

  #Private subnet CIDR for app-servers
  private_subnet_cidr   = ["10.0.3.0/24", "10.0.4.0/24"]

  #AZs for public and private subnets
  subnet_az             = module.my_vpc.available_azs_for_subnets

}

module "my_route_table" {
  source                    = "../modules/route_table"

  #VPC ID for internet gateway
  vpc_id                    = module.my_vpc.vpc_id

  #Public subnet for NAT gateway
  public_subnet_id          = module.my_vpc.public_subnet_id
  
  #Gateway IDs to create public and private route table
  gateway_id                = [module.my_route_table.igw_id, module.my_route_table.natgw_id]

  #Public subnets to be associated with public route table
  public_subnet_ids_count   = module.my_vpc.public_subnet_ids_count
  public_subnet_ids         = module.my_vpc.public_subnet_ids

  #Private subnets to be associated with public route table
  private_subnet_ids_count  = module.my_vpc.private_subnet_ids_count
  private_subnet_ids        = module.my_vpc.private_subnet_ids
}

module "my_security_group" {
  source                             = "../modules/security_groups"

  #VPC ID to create public and private security group
  vpc_id                             = module.my_vpc.vpc_id

  #Public subnet CIDR for SSH into private instances
  bastion_private_ip                  = module.my_auto_scaling_group.bastion_ip

  #VPC CIDR block For HTTP into private instances
  private_ingress_http_cidr          = module.my_vpc.vpc_cidr
}

module "my_auto_scaling_group" {
  source                      = "../modules/auto_scaling_group"

  #Number of instances in auto-scaling groups
  min_instance_count          = 1
  desired_instance_count      = 2
  max_instance_count          = 3

  #Public instance details
  public_instance_ami         = "ami-090fa75af13c156b4"
  public_instance_type        = "t2.micro"
  public_associate_public_ip  = true
  public_security_group_id    = module.my_security_group.public_security_group_id

  #Public auto-scaling group and subnets to assocaiate with public ALB
  public_target_group_arn     = module.my_application_load_balancers.public_target_group_arn
  public_subnet_ids           = module.my_vpc.public_subnet_ids

  #Private instance details
  private_instance_ami        = "ami-090fa75af13c156b4"
  private_instance_type       = "t2.micro"
  private_associate_public_ip = false
  private_security_group_id   = module.my_security_group.private_security_group_id

  #Private auto-scaling group and subnets to assocaiate with internal ALB
  private_target_group_arn    = module.my_application_load_balancers.private_target_group_arn
  private_subnet_ids          = module.my_vpc.private_subnet_ids 

  #Bastion hosts
  bastion_security_group_id   = module.my_security_group.bastion_security_group_id
  bastion_subnet_id           = module.my_vpc.public_subnet_id
}

module "my_application_load_balancers" {
  source                      = "../modules/load_balancers"

  #VPC ID to create public and private ALBs
  vpc_id                      = module.my_vpc.vpc_id

  #Public security group, subnets and auto-scaling group to associate with public ALB
  private_alb                 = false
  public_security_group_ids   = module.my_security_group.public_security_group_id
  public_subnet_ids           = module.my_vpc.public_subnet_ids
  public_target_id            = module.my_auto_scaling_group.public_asg_id

  #Private security group, subnets and auto-scaling group to associate with internal ALB
  private__alb                = true
  private_security_group_ids  = module.my_security_group.private_security_group_id
  private_subnet_ids          = module.my_vpc.private_subnet_ids
  private_target_id           = module.my_auto_scaling_group.private_asg_id
}

module "my_s3_buckets" {
  source                  = "../modules/s3"

  #VPC ID for VPC end point
  vpc_id                  = module.my_vpc.vpc_id

  #Route table IDs to associate with VPC end point
  route_table_ids         = [module.my_route_table.public_route_table_id, module.my_route_table.private_route_table_id]

  #Public subnet CIDR to restrict private bucket access
  subnet_cidrs            = module.my_vpc.public_subnet_cidrs
}


#Internet-facing ALB's DNS name
output "public_alb_dns_name" {
  value = module.my_application_load_balancers.public_alb_dns
}

#Internal ALB's DNS name
output "private_alb_dns_name" {
  value = module.my_application_load_balancers.private_alb_dns
}
