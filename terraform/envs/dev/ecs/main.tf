module "iam" {
  source = "../../../modules/iam"
  policy_name = "SecretsManagerGetSecretsValue"
  iam_policy = data.aws_iam_policy_document.getsecrets.json
  iam_role = "ecsTaskExecutionRole"
}

module "alb" {
  source                         = "../../../modules/loadbalancer"
  name                           = "skillset"
  lb_type                        = "application"
  target_type                    = "ip"
  vpc_id                         = data.aws_vpc.default.id
  public_subnets                 = data.aws_subnets.default_subnets.ids
  ingress_rules                  = var.ingress_rules
  enable_target_group_attachment = false
  user_ip                        = chomp(data.http.myip.response_body)
}


module "ecs" {
  source                   = "../../../modules/ecs"
  service_subnets          = data.aws_subnets.default_subnets.ids
  web_task_definition      = var.web_task_definition
  database_task_definition = var.database_task_definition
  service_definitions      = var.service_definitions
  target_group_arn         = module.alb.target_group_arn
  security_group_id        = module.alb.security_group_id
  username                 = local.username
  password                 = local.password
  app_secret_key           = local.app_secret_key
}