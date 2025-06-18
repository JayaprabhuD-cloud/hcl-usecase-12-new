# Creating IAM role for ec2 instance for secrets manager

resource "aws_iam_role" "ec2_app_role" {
  name = "${var.usecase_no}-secrets_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

# Creating IAM Policy for EC2 role

resource "aws_iam_role_policy" "app_secrets_policy" {
  name = "${var.usecase_no}-secrets_policy"
  role = aws_iam_role.ec2_app_role.id   
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = ["secretsmanager:GetSecretValue"],
      Resource = "*"
    }]
  })
}

# Creating instance profile and attaching iam role

#resource "aws_iam_instance_profile" "app_instance_profile" {
#  name = "app_instance_profile"
#  role = aws_iam_role.ec2_app_role.name
#}