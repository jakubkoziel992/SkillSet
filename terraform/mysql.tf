resource "aws_db_instance" "mysql" {
  identifier           = "skillset-db"
  allocated_storage    = 10
  db_name              = "skillset"
  engine               = "mysql"
  engine_version       = "8.0.40"
  instance_class       = "db.t3.micro"
  username             = var.username
  password             = var.password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = false
  multi_az             = false

  vpc_security_group_ids = [aws_security_group.skillset-rds-SG.id]
}

output "mysql_host" {
  value = aws_db_instance.mysql.endpoint
}