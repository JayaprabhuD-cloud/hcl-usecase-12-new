# Creating DB Subnet Group for Aurora Cluster
resource "aws_db_subnet_group" "subnet_group" {
  name       = "aurora-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.usecase_no}-aurora-subnet-group"
  }
}


resource "aws_rds_cluster" "db_cluster" {
  cluster_identifier           = "usecase12-mysql-cluster"
  engine                       = "aurora-mysql"
  engine_version               = "8.0.mysql_aurora.3.04.0"
  database_name                = "${var.usecase_no}_aurora_db"
  db_subnet_group_name         = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids       = var.db_security_group_id
  manage_master_user_password  = true
  master_username              = var.db_username
  skip_final_snapshot          = true
}

resource "aws_rds_cluster_instance" "aurora_db_instance" {
  identifier              = "bayer-aurora-instance"
  cluster_identifier      = aws_rds_cluster.db_cluster.id
  instance_class          = "db.t3.medium"
  engine                  = aws_rds_cluster.db_cluster.engine
  db_subnet_group_name    = aws_db_subnet_group.subnet_group.name
}