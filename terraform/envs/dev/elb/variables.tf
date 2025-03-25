variable "ingress_rules" {
  description = "ingress rules values"
  type = map(object({
    description = string
    cidr_ipv4   = string
    port        = number
    protocol    = string
  }))
}