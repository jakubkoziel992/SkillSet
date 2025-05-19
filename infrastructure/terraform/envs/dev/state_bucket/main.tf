module "state_bucket" {
  source        = "../../../modules/remote_state"
  environment   = "dev"
  force_destroy = false
}