#--------------------------------------------------------------------------------
#Public ALB
#----------

resource "aws_lb" "epam_public_alb" {
    name               = var.public_alb_name
    internal           = var.private_alb
    load_balancer_type = var.elb_type
    security_groups    = var.public_security_group_ids
    subnets            = var.public_subnet_ids
}

resource "aws_lb_target_group" "epam_public_alb_target_group" {
    name     = var.public_target_group_name
    port     = var.http_port
    protocol = var.http_protocol
    vpc_id   = var.vpc_id
}

resource "aws_autoscaling_attachment" "epam_public_asg_attachment" {
  autoscaling_group_name = var.public_target_id
  lb_target_group_arn    = aws_lb_target_group.epam_public_alb_target_group.arn
}

resource "aws_lb_listener" "epam_public_alb_listener" {
  load_balancer_arn = aws_lb.epam_public_alb.arn
  port              = var.http_port
  protocol          = var.http_protocol
  default_action {
    type             = var.elb_listener_type
    target_group_arn = aws_lb_target_group.epam_public_alb_target_group.arn
  }
}

#--------------------------------------------------------------------------------
#Internal ALB
#------------

resource "aws_lb" "epam_private_alb" {
    name               = var.private_alb_name
    internal           = var.private__alb
    load_balancer_type = var.elb_type
    security_groups    = var.private_security_group_ids
    subnets            = var.private_subnet_ids
}

resource "aws_lb_target_group" "epam_private_alb_target_group" {
    name     = var.private_target_group_name
    port     = var.http_port
    protocol = var.http_protocol
    vpc_id   = var.vpc_id
}

resource "aws_autoscaling_attachment" "epam_private_asg_attachment" {
  autoscaling_group_name = var.private_target_id
  lb_target_group_arn    = aws_lb_target_group.epam_private_alb_target_group.arn
}

resource "aws_lb_listener" "epam_private_alb_listener" {
  load_balancer_arn = aws_lb.epam_private_alb.arn
  port              = var.http_port
  protocol          = var.http_protocol
  default_action {
    type             = var.elb_listener_type
    target_group_arn = aws_lb_target_group.epam_private_alb_target_group.arn
  }
}