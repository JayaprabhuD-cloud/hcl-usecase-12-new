variable "private_subnet_ids" {
  type = list(string)
}

variable "db_security_group_id" {
  description = "List of security group IDs for the EC2 instance"
  type        = list(string)
}

variable "db_username" {}