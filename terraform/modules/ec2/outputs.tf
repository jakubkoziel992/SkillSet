output "ec2_id" {
  value = aws_instance.flask-app.id
}

output "ec2_ip" {
  value = aws_instance.flask-app.public_ip
}

