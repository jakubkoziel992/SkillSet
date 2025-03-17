module "sm" {
  source = "../../../modules/secrets_manager"
  name = "skillset"
  environment = "prod"
  username = "admin"
}