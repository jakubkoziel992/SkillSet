variable "environment" {
  description = "The environment name"
  type        = string
}

variable "force_destroy" {
  description = "Boolean that indicates all objects should be deleted from the bucket when the bucket is destroyed."
  type        = bool
}


variable "block_public_acls" {
  description = "block public ACLs for the S3 bucket."
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "ignore public ACLs for the S3 bucket."
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "block public bucket policies."
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "restrict access to public buckets."
  type        = bool
  default     = true
}