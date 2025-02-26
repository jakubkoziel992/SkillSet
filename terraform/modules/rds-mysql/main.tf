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
  skip_final_snapshot  = true
  publicly_accessible  = false
  multi_az             = false

  vpc_security_group_ids = [aws_security_group.skillset-rds-SG.id]
}



resource "aws_security_group" "skillset-rds-SG" {
  name        = "skillset-rds-SG"
  description = "Allow mysql from EC2"
  vpc_id      = var.vpc_id

}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql_from_EC2" {
  description                  = "Allow traffic to Mysql for web-SG"
  security_group_id            = aws_security_group.skillset-rds-SG.id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
  referenced_security_group_id = var.ec2_SG
}