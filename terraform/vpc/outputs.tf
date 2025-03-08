output "private_subnets" {
  description = "The private subnets"
  value = module.vpc.private_subnets
}

output "public_subnet" {
  description = "Public subnet 1"
  value = module.vpc.public_subnets[0]
  
}