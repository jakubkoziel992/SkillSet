resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic from owner IP"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "${chomp(data.http.myip.response_body)}/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_security_group" "skillset-rds-SG" {
  name        = "skillset-rds-SG"
  description = "Allow mysql from EC2"
  vpc_id      = data.aws_vpc.default.id

}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql_from_EC2" {
  security_group_id            = aws_security_group.skillset-rds-SG.id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
  referenced_security_group_id = "sg-06f5267a52d7b61ff"
}


output "ip" {
  value = chomp(data.http.myip.response_body)
}