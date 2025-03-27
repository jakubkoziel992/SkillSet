resource "aws_security_group" "skillset-web-SG" {
  name        = "skillset-SG"
  description = "Allow SSH inbound traffic from owner IP"
  vpc_id      = var.vpc_id

  tags = {
    Name = "skillset-SG"
  }
}


resource "aws_vpc_security_group_ingress_rule" "example" {
  for_each = var.ingress_rules

  description                  = each.value.description
  security_group_id            = aws_security_group.skillset-web-SG.id
  cidr_ipv4                    = each.value.from_port == 22 ? "${var.ec2_ip}/32" : null
  from_port                    = each.value.from_port
  ip_protocol                  = each.value.ip_protocol
  to_port                      = each.value.to_port
  referenced_security_group_id = each.key == "allow-elb" ? var.elb_sg_id : null
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
  vpc_id      = var.vpc_id

}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql_from_EC2" {
  for_each = var.DB_ingress_rules

  description                  = each.value.description
  security_group_id            = aws_security_group.skillset-rds-SG.id
  from_port                    = each.value.port
  to_port                      = each.value.port
  ip_protocol                  = each.value.ip_protocol
  referenced_security_group_id = each.value.port == 3306 ? aws_security_group.skillset-web-SG.id : each.value.referenced_security_group_id
}





