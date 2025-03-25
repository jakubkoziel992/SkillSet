module "sm" {
  source          = "../../../modules/secrets_manager"
  name            = "skillset"
  environment     = "dev"
  username        = "admin"
  recovery_window = 0
}
