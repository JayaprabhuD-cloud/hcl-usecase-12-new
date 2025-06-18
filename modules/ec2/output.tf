output "instance_ip" {
  description = "Application instance public ip"
  value = aws_instance.app_ec2.public_ip
}