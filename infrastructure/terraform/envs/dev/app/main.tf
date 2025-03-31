locals {
  ip_address = chomp(data.http.myip.response_body)
  vpc_id     = data.aws_vpc.default.id
  subnets_id = data.aws_subnets.default_subnets.ids
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
  private_subnets      = local.subnets_id
  rds_sg               = module.sg.rds_sg
  project_name         = var.project_name
  environment          = var.environment
}

module "ec2" {
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
  subnet_id              = data.aws_subnet.ec2_subnet.id
  ec2_sg                 = module.sg.ec2_sg
}

module "lb" {
  source                         = "../../../modules/loadbalancer"
  project_name                   = var.project_name
  environment                    = var.environment
  lb_type                        = "application"
  vpc_id                         = local.vpc_id
  public_subnets                 = local.subnets_id
  ec2_instance_ids               = [module.ec2.ec2_id]
  ingress_rules                  = var.alb_ingress_rules
  user_ip                        = local.ip_address
  enable_target_group_attachment = true
}