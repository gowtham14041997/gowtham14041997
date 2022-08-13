output "public_target_group_arn" {
  value = list(aws_lb_target_group.epam_public_alb_target_group.arn)
}

output "private_target_group_arn" {
  value = list(aws_lb_target_group.epam_private_alb_target_group.arn)
}

output "public_alb_dns" {
  value = aws_lb.epam_public_alb.dns_name
}

output "private_alb_dns" {
  value = aws_lb.epam_private_alb.dns_name
}