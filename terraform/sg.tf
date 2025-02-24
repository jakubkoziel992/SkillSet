resource "aws_security_group" "skillset-web-SG" {
  name        = "inound rule"
  description = "Allow SSH inbound traffic from owner IP"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "skillset-web-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  description       = "Allow ssh from my IP"
  security_group_id = aws_security_group.skillset-web-SG.id
  cidr_ipv4         = "${chomp(data.http.myip.response_body)}/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_traffic_to_port_80" {
  description       = "open port 80"
  security_group_id = aws_security_group.skillset-web-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  description       = "allow outbound traffic"
  security_group_id = aws_security_group.skillset-web-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 0
  ip_protocol       = -1
  to_port           = 0
}

resource "aws_security_group" "skillset-rds-SG" {
  name        = "skillset-rds-SG"
  description = "Allow mysql from EC2"
  vpc_id      = data.aws_vpc.default.id

}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql_from_EC2" {
  description                  = "Allow traffic to Mysql for web-SG"
  security_group_id            = aws_security_group.skillset-rds-SG.id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.skillset-web-SG.id
}