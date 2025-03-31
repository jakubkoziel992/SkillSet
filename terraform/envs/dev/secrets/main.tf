module "sm" {
  source          = "../../../modules/secrets_manager"
  project_name    = "skillset"
  environment     = "dev"
  username        = "admin"
  recovery_window = 0
}
