#[aws_security_group.bayer_app_sg.id]
#"ami-0b09627181c8d5778"

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "public_subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "app_security_group_id" {
  description = "List of security group IDs for the EC2 instance"
  type        = list(string)
}

variable "iam_role_name" {
  description = "IAM role name for the instance profile"
  type        = string
}

variable "usecase_no" {
  description = "Variable for usecase"
  type        = string
}