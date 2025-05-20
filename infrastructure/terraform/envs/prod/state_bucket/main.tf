module "state_bucket" {
  source        = "../../../modules/remote_state"
  environment   = "prod"
  force_destroy = true
}