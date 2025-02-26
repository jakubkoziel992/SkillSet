module "rds" {
  source   = "./modules/rds-mysql"
  username = var.username
  password = var.password
  db_name  = var.db_name 
  engine   = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  instance_identifier = var.instance_identifier
  allocated_storage = var.allocated_storage
  parameter_group_name = var.parameter_group_name
  vpc_id   = data.aws_vpc.default.id
  ec2_SG   = module.ec2.ec2_SG
}

module "ec2" {
  source   = "./modules/ec2"
  username = var.username
  password = var.password
  
  ami_id   = data.aws_ami.ubuntu.id
  db_name  = module.rds.mysql_host
  vpc_id   = data.aws_vpc.default.id
  db_host  = module.rds.mysql_host
  ec2_ip   = chomp(data.http.myip.response_body)
}
