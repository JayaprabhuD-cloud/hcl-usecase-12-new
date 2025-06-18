# Creating Application Instance

resource "aws_instance" "app_ec2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = var.app_security_group_id
  iam_instance_profile        = aws_iam_instance_profile.app_instance_profile.name
  associate_public_ip_address = true

  tags = {
    Name = "${var.usecase_no}-application"
  }
}

resource "aws_iam_instance_profile" "app_instance_profile" {
  name = "app_instance_profile"
  role = var.iam_role_name
}