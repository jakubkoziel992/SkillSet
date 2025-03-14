variable "vpc_id" {}

variable "ec2_ip" {
  description = "EC2 instance ipv4 address"
  type        = string
}

variable "ingress_rules" {
  description = "EC2 instance ingress rules"
  type = map(object({
    description       = string
    security_group_id = optional(string)
    cidr_ipv4         = string
    from_port         = number
    ip_protocol       = string
    to_port           = number
  }))
}

variable "DB_ingress_rules" {
  description = "Mysql ingress rule"
  type = map(object({
    description                  = string
    security_group_id            = optional(string)
    port                         = number
    ip_protocol                  = string
    referenced_security_group_id = string
  }))
}
