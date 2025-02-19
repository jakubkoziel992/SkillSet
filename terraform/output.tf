output "ip" {
  value = chomp(data.http.myip.response_body)
}

output "mysql_host" {
  value = aws_db_instance.mysql.endpoint
}


output "ec2_instance_host" {
  value = aws_instance.flask-app.public_dns
}

