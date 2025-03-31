locals {
  ip_address        = chomp(data.http.myip.response_body)
  vpc_id            = data.aws_vpc.vpc.id
  public_subnet_ids = data.terraform_remote_state.vpc.outputs.public_subnets
}


module "sg" {
  source           = "../../../modules/sg"
  project_name     = var.project_name
  environment      = var.environment
  vpc_id           = local.vpc_id
  ingress_rules    = var.ingress_rules
  DB_ingress_rules = var.DB_ingress_rules
  ec2_ip           = local.ip_address
  elb_sg_id        = module.lb.security_group_id

}

module "rds" {
  source               = "../../../modules/rds-mysql"
  project_name         = var.project_name
  environment          = var.environment
  username             = local.username
  password             = local.password
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  instance_identifier  = var.instance_identifier
  allocated_storage    = var.allocated_storage
  parameter_group_name = var.parameter_group_name
  vpc_id               = local.vpc_id
  snapshot             = var.snapshot
  public_access        = var.public_access
  multi_az             = var.multi_az
  private_subnets      = data.terraform_remote_state.vpc.outputs.private_subnets
  rds_sg               = module.sg.rds_sg
}

module "ec2-1" {
  source                 = "../../../modules/ec2"
  username               = local.username
  password               = local.password
  availability_zone      = var.availability_zone
  instance_type          = var.instance_type
  instance_name          = var.instance_name
  volume_size            = var.volume_size
  key_algorithm          = var.key_algorithm
  key_name               = var.key_name
  private_key_permission = var.private_key_permission
  key_path               = var.key_path
  flask_app              = var.flask_app
  db_name                = var.db_name
  vpc_id                 = local.vpc_id
  db_host                = module.rds.mysql_host
  app_secret_key         = local.app_secret_key
  subnet_id              = local.public_subnet_ids[0]
  ec2_sg                 = module.sg.ec2_sg
}

module "ec2-2" {
  source                 = "../../../modules/ec2"
  username               = local.username
  password               = local.password
  availability_zone      = "us-east-1b"
  instance_type          = var.instance_type
  instance_name          = "skillset-web-2"
  volume_size            = var.volume_size
  key_algorithm          = var.key_algorithm
  key_name               = "flask-app-2"
  private_key_permission = var.private_key_permission
  key_path               = "C:\\Users\\jakub.koziel\\Downloads/flask-app2.pem"
  flask_app              = var.flask_app
  db_name                = var.db_name
  vpc_id                 = local.vpc_id
  db_host                = module.rds.mysql_host
  app_secret_key         = local.app_secret_key
  subnet_id              = local.public_subnet_ids[1]
  ec2_sg                 = module.sg.ec2_sg
}


module "lb" {
  source                         = "../../../modules/loadbalancer"
  vpc_id                         = local.vpc_id
  project_name                   = var.project_name
  environment                    = var.environment
  lb_type                        = "application"
  public_subnets                 = local.public_subnet_ids
  ec2_instance_ids               = [module.ec2-1.ec2_id, module.ec2-2.ec2_id]
  user_ip                        = local.ip_address
  ingress_rules                  = var.alb_ingress_rules
  enable_target_group_attachment = true
}