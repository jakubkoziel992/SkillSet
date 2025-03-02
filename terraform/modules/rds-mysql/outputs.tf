output "mysql_host" {
  value = aws_db_instance.mysql.endpoint
}

output "rds_vpc_id" {
  value = aws_db_subnet_group.db-subnet-group.vpc_id
}