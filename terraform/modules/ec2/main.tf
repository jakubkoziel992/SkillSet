#security group
resource "aws_security_group" "skillset-web-SG" {
  name        = "inound rule"
  description = "Allow SSH inbound traffic from owner IP"
  vpc_id      = var.vpc_id

  tags = {
    Name = "skillset-web-SG"
  }
}


resource "aws_vpc_security_group_ingress_rule" "example" {
  for_each = var.ingress_rules

  description       = each.value.description
  security_group_id = aws_security_group.skillset-web-SG.id
  cidr_ipv4         = each.value.from_port == 22 ? "${var.ec2_ip}/32" : each.value.cidr_ipv4
  from_port         = each.value.from_port
  ip_protocol       = each.value.ip_protocol
  to_port           = each.value.to_port
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  description       = "allow outbound traffic"
  security_group_id = aws_security_group.skillset-web-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 0
  ip_protocol       = -1
  to_port           = 0
}

#ec2
resource "aws_instance" "flask-app" {

  availability_zone = var.availability_zone
  ami               = var.ami_id
  instance_type     = var.instance_type

  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.skillset-web-SG.id
  ]

  key_name = aws_key_pair.flask.key_name

  user_data = templatefile(
    "./init_app.sh",
    {
      app_env     = var.flask_app,
      db_user     = var.username,
      db_password = var.password,
      db_host     = var.db_host,
      db_name     = var.db_name
    }
  )

  user_data_replace_on_change = true

  root_block_device {
    volume_size = var.volume_size
  }

  tags = {
    Name = "Skillset-web"
  }
}

resource "tls_private_key" "my_key" {
  algorithm = var.key_algorithm
  rsa_bits  = 4096
}

resource "aws_key_pair" "flask" {
  key_name   = var.key_name
  public_key = tls_private_key.my_key.public_key_openssh
}

resource "local_file" "private_key" {
  filename        = "C:\\Users\\jakub.koziel\\Downloads/flask-app.pem"
  content         = tls_private_key.my_key.private_key_pem
  file_permission = "0600"
}