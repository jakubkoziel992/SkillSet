# output "ec2_host" {
#   description = "EC2 address"
#   value       = module.ec2.ec2_instance_host 
# }

output "ec2_ip" {
  value = module.ec2.ec2_ip
}

output "ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "vpc_id" {
  value = data.aws_vpc.default.id
}