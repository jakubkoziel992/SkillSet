variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}


variable "app_secret_key" {
  description = "application SECRET_KEY"
  type        = string
  sensitive   = true
}