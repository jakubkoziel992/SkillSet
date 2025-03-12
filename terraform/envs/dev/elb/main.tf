module "lb" {
  source           = "../../../modules/loadbalancer"
  name             = "skillset"
  lb_type          = "application"
  subnets          = data.aws_subnets.default_subnets.ids
  ec2_instance_ids = ["i-0b8c798105254576e"]
}