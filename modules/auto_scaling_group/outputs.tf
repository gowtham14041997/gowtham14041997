output "public_asg_id" {
  value = aws_autoscaling_group.epam_public_asg.id
}

output "private_asg_id" {
  value = aws_autoscaling_group.epam_private_asg.id
}

output "bastion_ip" {
  value = aws_instance.epam_bastion_host.private_ip
}