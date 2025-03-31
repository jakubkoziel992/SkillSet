output "elb_address" {
  value = aws_lb.skillset-lb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.target_elb.arn
}

output "security_group_id" {
  value = aws_security_group.skillset-ELB-SG.id
}