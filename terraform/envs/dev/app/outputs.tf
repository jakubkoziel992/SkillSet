# output "ec2_ip" {
#   value = module.ec2.ec2_ip
# }

# output "rds_vpc_id" {
#   value = module.rds.rds_vpc_id
# }
output "ec2_id" {
  value = module.ec2.ec2_id
}

# output "ec2_subnet_id" {
#   value = data.aws_subnet.ec2_subnet.id
# }