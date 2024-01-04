provider "aws" {
  region  = "ap-southeast-1"
  profile = var.profile
}

module "vpc" {
  source  = "./modules/vpc"
  cidr    = var.vpc_cidr
  project = var.project
}

module "subnet" {
  source         = "./modules/subnet"
  project        = var.project
  vpc_id         = module.vpc.main.id
  subnet_details = var.subnet_details
}

module "routetable" {
  source              = "./modules/routetable"
  project             = var.project
  main_route_table_id = module.vpc.main.default_route_table_id
  vpc_id               = module.vpc.main.id
  public_subnet_1_id  = module.subnet.public_subnet_1.id
  public_subnet_2_id  = module.subnet.public_subnet_2.id
}

module "securitygroup" {
  source       = "./modules/securitygroup"
  project      = var.project
  vpc_id       = module.vpc.main.id
}

module "ec2" {
  source                = "./modules/ec2"
  project               = var.project
  ami                   = var.ami_id
  instance_type         = var.instance_type
  app_security_group_id = module.securitygroup.app_security_group.id
  public_subnets_ids = [module.subnet.public_subnet_1.id, module.subnet.public_subnet_2.id]
}

module "alb" {
  source             = "./modules/alb"
  project            = var.project
  vpc_id             = module.vpc.main.id
  alb_subnet_1_id    = module.subnet.public_subnet_1.id
  alb_subnet_2_id    = module.subnet.public_subnet_2.id
  alb_security_group = module.securitygroup.alb_security_group.id
  app_instance_ids    = module.ec2.app_instance_ids
}