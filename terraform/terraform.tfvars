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