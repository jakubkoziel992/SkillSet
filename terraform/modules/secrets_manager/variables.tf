variable "name" {
  description = "Project name"
  type        = string 
}

variable "environment" {
    description = "Environment name"
    type        = string  
  
}

variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
  default = null
}


variable "app_secret_key" {
  description = "application SECRET_KEY"
  type        = string
  sensitive   = true
  default     = null
}