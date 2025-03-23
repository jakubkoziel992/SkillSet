ingress_rules = {
  "http" = {
    desciption = "Allow HTTP request from anywhere"
    cidr_ipv4 = "0.0.0.0/0"
    port      = 80
    protocol   = "tcp"    
  }
}