module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block        = var.vpc_cidr_block
  usecase_no            = var.usecase_no
  public_subnet_1_cidr  = var.public_subnet_1_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
}

module "iam" {
  source     = "./modules/iam"
  usecase_no = var.usecase_no
}

module "ec2" {
  source                 = "./modules/ec2"
  ami                    = var.ami
  instance_type          = var.instance_type
  public_subnet_id       = module.vpc.public_subnet_id
  app_security_group_id  = [module.vpc.app_security_group_id]
  iam_role_name          = module.iam.iam_role_name
  usecase_no             = var.usecase_no
}

module "rds" {
  source                  = "./modules/rds"
  private_subnet_ids      = module.vpc.private_subnet_ids
  db_security_group_id    = [module.vpc.db_security_group_id]
  db_username             = var.db_username
  usecase_no              = var.usecase_no
}


