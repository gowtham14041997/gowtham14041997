output "public_security_group_id" {
    value = list(aws_security_group.epam_public_security_group.id)
}

output "private_security_group_id" {
    value = list(aws_security_group.epam_private_security_group.id)
}

output "bastion_security_group_id" {
    value = list(aws_security_group.epam_bastion_security_group.id)
}

