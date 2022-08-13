output "vpc_id" {
    value = aws_vpc.epam_vpc.id
}

output "available_azs_for_subnets" {
    value = data.aws_availability_zones.available_azs.names
}
output "vpc_cidr" {
    value = list(aws_vpc.epam_vpc.cidr_block)
}

output "public_subnet_id" {
    value = element(aws_subnet.epam_public_subnet.*.id, 0)
}

output "public_subnet_ids_count" {
    value = length(aws_subnet.epam_public_subnet.*.id)
}

output "public_subnet_ids" {
    value = aws_subnet.epam_public_subnet.*.id
}

output "public_subnet_cidrs" {
    value = aws_subnet.epam_public_subnet.*.cidr_block
}

output "private_subnet_ids_count" {
    value = length(aws_subnet.epam_private_subnet.*.id)
}

output "private_subnet_ids" {
    value = aws_subnet.epam_private_subnet.*.id
}

