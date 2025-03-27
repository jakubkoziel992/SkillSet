module "lb" {
  source           = "../../../modules/loadbalancer"
  vpc_id           = data.aws_vpc.vpc.id
  name             = "skillset"
  lb_type          = "application"
  public_subnets   = data.terraform_remote_state.vpc.outputs.public_subnets
  ec2_instance_ids = data.aws_instances.ec2_instances.ids
  user_ip          = chomp(data.http.myip.response_body)
  ingress_rules    = var.ingress_rules
}