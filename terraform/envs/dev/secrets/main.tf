module "sm" {
  source = "../../../modules/secrets_manager"
  name = "skillset"
  environment = "dev"
  username = "admin"
}