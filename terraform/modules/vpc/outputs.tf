output "private_subnets" {
  description = "The private subnets created"
  value       = [for subnet in aws_subnet.private_subnet : subnet.id]
}

output "public_subnets" {
  description = "The private subnets created"
  value       = [for subnet in aws_subnet.public_subnet : subnet.id]
}