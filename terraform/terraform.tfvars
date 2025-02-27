db_name = "skillset"
engine =  "mysql"
engine_version = "8.0.40"
instance_class = "db.t3.micro"
allocated_storage = 10
instance_identifier = "skillset-db"
parameter_group_name = "default.mysql8.0"
availability_zone = "us-east-1a"
instance_type = "t2.micro"
volume_size = "20"
key_algorithm = "RSA"
key_name = "flask-app"
flask_app = "prod"

ingress_rules = {
  "allow-ssh" = {
    description = "Allow ssh"
    cidr_ipv4   = "0.0.0.0/0"
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"

  },
  "allow-http" = {
    description = "allow_all_traffic_to_port_80"
    cidr_ipv4   = "0.0.0.0/0"
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"

  }
}