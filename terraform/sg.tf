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

output "ip" {
    value = chomp(data.http.myip.response_body)
}