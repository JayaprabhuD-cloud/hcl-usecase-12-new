output "iam_role_arn" {
  description = "ec2 instance secrets role arn"
  value = aws_iam_role.ec2_app_role.arn
}


output "iam_role_name" {
  description = "ec2 instance secrets role name"
  value = aws_iam_role.ec2_app_role.name
}