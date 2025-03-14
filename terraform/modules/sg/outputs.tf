output "rds_sg" {
  value = aws_security_group.skillset-rds-SG.id
}


output "ec2_sg" {
  value = aws_security_group.skillset-web-SG.id
}