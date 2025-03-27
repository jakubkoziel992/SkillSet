db_name                = "skillset"
engine                 = "mysql"
engine_version         = "8.0.40"
instance_class         = "db.t3.micro"
allocated_storage      = 10
instance_identifier    = "skillset-db"
parameter_group_name   = "default.mysql8.0"
availability_zone      = "us-east-1a"
instance_type          = "t2.micro"
instance_name          = "skillset-web-1"
volume_size            = "20"
key_algorithm          = "RSA"
private_key_permission = "0600"
key_path               = "C:\\Users\\jakub.koziel\\Downloads/flask-app.pem"
key_name               = "flask-app"
flask_app              = "prod"
snapshot               = true
public_access          = false
multi_az               = false

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

DB_ingress_rules = {
  "allow-ssh" = {
    description = "Allow traffic from EC2"
    port        = 3306
    ip_protocol = "tcp"
  }
}

alb_ingress_rules = {
  "http" = {
    description = "Allow HTTP request from anywhere"
    cidr_ipv4  = "0.0.0.0/0"
    port       = 80
    protocol   = "tcp"
  }
}