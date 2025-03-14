output "elb_address" {
  value = aws_lb.skillset-lb.dns_name
}