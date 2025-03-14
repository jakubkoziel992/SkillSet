module "lb" {
  source           = "../../../modules/loadbalancer"
  name             = "skillset"
  lb_type          = "application"
  vpc_id           =  data.aws_vpc.default.id
  public_subnets   = data.aws_subnets.default_subnets.ids
  ec2_instance_ids = [data.terraform_remote_state.app.outputs.ec2_id]
}