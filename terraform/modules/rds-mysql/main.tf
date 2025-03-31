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

  vpc_security_group_ids = [var.rds_sg]

  tags = {
    Name = "${var.project_name}-${var.environment}-RDS"
  }
}

resource "aws_db_subnet_group" "db-subnet-group" {
  subnet_ids = var.private_subnets
}