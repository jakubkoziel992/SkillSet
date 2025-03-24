resource "random_password" "password" {
  count = var.environment != "prod" ? 1 : 0
  length    = 16
  special   = true
  upper     = true
  lower     = true
  override_special = "!#()^"
}

resource "random_password" "key" {
  count = var.environment != "prod" ? 1 : 0
  length    = 16
  special   = true 
  upper     = true
  lower     = true
  override_special = "!#()^"
}


resource "aws_secretsmanager_secret" "secret_manager" {
  name = "${var.environment}-${var.name}-sm"
  description = "Application secrets for ${var.environment}"
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id = aws_secretsmanager_secret.secret_manager.id
  secret_string = jsonencode(
   {
    username: var.username,
    password: var.password != null ? var.password : random_password.password[0].result,
    app_secret_key: var.app_secret_key != null  ? var.app_secret_key : random_password.key[0].result
   })
}
