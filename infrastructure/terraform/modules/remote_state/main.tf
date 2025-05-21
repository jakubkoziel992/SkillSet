resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket_prefix = "terraform-state-${var.environment}"
  force_destroy = var.force_destroy

  tags = {
    environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state_public_access_block" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  block_public_acls       = var.block_public_acls
  ignore_public_acls      = var.ignore_public_acls
  block_public_policy     = var.block_public_policy
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "terraform_state_lifecycle_configuration" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  rule {
    id = "delete-old-versions"
    status = "Enabled"
    
    filter {
      prefix = ""
    }
    
    expiration {
      days = 5
    }

     noncurrent_version_expiration {
      noncurrent_days = 1
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name                        = "terraform-remote-state-${var.environment}"
  billing_mode                = "PAY_PER_REQUEST"
  hash_key                    = "LockID"
  deletion_protection_enabled = false
  attribute {
    name = "LockID"
    type = "S"
  }
}