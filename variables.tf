variable "vpc_cidr_block" {
  description = "vpc variable"
  type = string
}

variable "usecase_no" {}

variable "public_subnet_1_cidr" {}
variable "private_subnet_1_cidr" {}
variable "private_subnet_2_cidr" {}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}


variable "db_username" {
  description = "master_username"
  type = string
}