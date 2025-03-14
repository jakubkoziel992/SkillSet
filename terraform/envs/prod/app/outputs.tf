output "ec2_ip-1" {
  value = module.ec2-1.ec2_ip
}

output "ec2_ip-2" {
  value = module.ec2-2.ec2_ip
}

output "rds_vpc_id" {
  value = module.rds.rds_vpc_id
}
