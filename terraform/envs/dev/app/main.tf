module "rds" {
  source               = "../../modules/rds-mysql"
  username             = var.username
  password             = var.password
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  instance_identifier  = var.instance_identifier
  allocated_storage    = var.allocated_storage
  parameter_group_name = var.parameter_group_name
  vpc_id               = data.aws_vpc.default.id
  ec2_SG               = module.ec2.ec2_SG
  snapshot             = var.snapshot
  public_access        = var.public_access
  multi_az             = var.multi_az
  DB_ingress_rules     = var.DB_ingress_rules
  private_subnets      = ["subnet-0bbd82ddf3a1a7bd7", "subnet-00cf1518d7a480016"]
}

module "ec2" {
  source                 = "../../modules/ec2"
  username               = var.username
  password               = var.password
  availability_zone      = var.availability_zone
  instance_type          = var.instance_type
  instance_name          = var.instance_name
  volume_size            = var.volume_size
  key_algorithm          = var.key_algorithm
  key_name               = var.key_name
  private_key_permission = var.private_key_permission
  key_path               = var.key_path
  flask_app              = var.flask_app
  ingress_rules          = var.ingress_rules
  db_name                = var.db_name
  vpc_id                 = data.aws_vpc.default.id
  db_host                = module.rds.mysql_host
  ec2_ip                 = chomp(data.http.myip.response_body)
  app_secret_key         = var.app_secret_key
  subnet_id              = "subnet-0bbd82ddf3a1a7bd7"
}
