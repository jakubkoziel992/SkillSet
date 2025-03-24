module "alb" {
  source           = "../../../modules/loadbalancer"
  name             = "skillset"
  lb_type          = "application"
  target_type      = "ip" 
  vpc_id           =  data.aws_vpc.vpc.id
  public_subnets   = data.terraform_remote_state.vpc.outputs.public_subnets
  ec2_instance_ids = []
  ingress_rules    = var.ingress_rules
  enable_target_group_attachment = false
}


module "ecs" {
  source = "../../../modules/ecs"
  service_subnets = data.terraform_remote_state.vpc.outputs.private_subnets
  task_definitions = var.task_definitions
  service_definitions = var.service_definitions
  target_group_arn = module.alb.target_group_arn
  security_group_id = module.alb.security_group_id
  assign_public_ip = false
}