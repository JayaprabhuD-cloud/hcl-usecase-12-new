output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.bayer_vpc.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.bayer_public_subnet_1.id
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = [
    aws_subnet.bayer_private_subnet_1.id,
    aws_subnet.bayer_private_subnet_2.id
  ]
}

output "app_security_group_id" {
  value = aws_security_group.bayer_app_sg.id
}

output "db_security_group_id" {
  value = aws_security_group.bayer_db_sg.id
}