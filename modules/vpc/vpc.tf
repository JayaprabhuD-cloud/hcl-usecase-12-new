resource "aws_vpc" "bayer_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.usecase_no}-vpc"
  }
}

resource "aws_internet_gateway" "bayer_igw" {
  vpc_id = aws_vpc.bayer_vpc.id

  tags = {
    Name = "${var.usecase_no}-igw"
  }
}

resource "aws_subnet" "bayer_public_subnet_1" {
  vpc_id                  = aws_vpc.bayer_vpc.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.usecase_no}-pub-sub-1"
  }
}

resource "aws_route_table" "bayer_public_rt" {
  vpc_id = aws_vpc.bayer_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bayer_igw.id
  }

  tags = {
    Name = "${var.usecase_no}-pub-rt"
  }
}

resource "aws_route_table_association" "bayer_assoc_subnet_1" {
  subnet_id      = aws_subnet.bayer_public_subnet_1.id
  route_table_id = aws_route_table.bayer_public_rt.id
}

resource "aws_eip" "nat_1" {
  domain = "vpc"

  tags = {
    Name = "${var.usecase_no}-eip"
  }
}

resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.nat_1.id
  subnet_id     = aws_subnet.bayer_public_subnet_1.id

  tags = {
    Name = "${var.usecase_no}-nat"
  }
}

resource "aws_subnet" "bayer_private_subnet_1" {
  vpc_id                  = aws_vpc.bayer_vpc.id
  cidr_block              = var.private_subnet_1_cidr
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.usecase_no}-pri-sub-1"
  }
}

resource "aws_subnet" "bayer_private_subnet_2" {
  vpc_id                  = aws_vpc.bayer_vpc.id
  cidr_block              = var.private_subnet_2_cidr
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.usecase_no}-pri-sub-2"
  }
}

resource "aws_route_table" "bayer_private_rt" {
  vpc_id = aws_vpc.bayer_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_1.id
  }

  tags = {
    Name = "${var.usecase_no}-pri-rt"
  }
}

resource "aws_route_table_association" "assoc_pri_subnet_1" {
  subnet_id      = aws_subnet.bayer_private_subnet_1.id
  route_table_id = aws_route_table.bayer_private_rt.id
}

resource "aws_route_table_association" "assoc_pri_subnet_2" {
  subnet_id      = aws_subnet.bayer_private_subnet_2.id
  route_table_id = aws_route_table.bayer_private_rt.id
}

#  Creating security group for Application Instance

resource "aws_security_group" "bayer_app_sg" {
  name        = "${var.usecase_no}-app-sg"
  description = "Allow HTTP & SSH"
  vpc_id      = aws_vpc.bayer_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creating security group for DB Instances

resource "aws_security_group" "bayer_db_sg" {
  name   = "${var.usecase_no}-db-sg"
  vpc_id = aws_vpc.bayer_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.bayer_app_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}