output "ip" {
  value = var.ec2_ip
}

output "ec2_id" {
  value = aws_instance.flask-app.id
}

output "ec2_SG" {
  value = aws_security_group.skillset-web-SG.id
}

output "ec2_ip" {
  value = aws_instance.flask-app.public_ip
}

