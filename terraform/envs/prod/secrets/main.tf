module "sm" {
  source          = "../../../modules/secrets_manager"
  name            = "skillset"
  environment     = "prod"
  recovery_window = 0
  username        = var.username
  password        = var.password
  app_secret_key  = var.app_secret_key
}