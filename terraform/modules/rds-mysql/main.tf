resource "aws_db_instance" "mysql" {
  identifier           = var.instance_identifier
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.snapshot
  publicly_accessible  = var.public_access
  multi_az             = var.multi_az
  db_subnet_group_name = aws_db_subnet_group.db-subnet-group.id


  vpc_security_group_ids = [aws_security_group.skillset-rds-SG.id]
}

resource "aws_db_subnet_group" "db-subnet-group" {
  subnet_ids = var.private_subnets
}


resource "aws_security_group" "skillset-rds-SG" {
  name        = "skillset-rds-SG"
  description = "Allow mysql from EC2"
  vpc_id      = var.vpc_id

}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql_from_EC2" {
  for_each = var.DB_ingress_rules

  description                  = each.value.description
  security_group_id            = aws_security_group.skillset-rds-SG.id
  from_port                    = each.value.port
  to_port                      = each.value.port
  ip_protocol                  = each.value.ip_protocol
  referenced_security_group_id = each.value.port == 3306 ? var.ec2_SG : each.value.referenced_security_group_id
}