locals {
  purpose     = lower(replace(replace(var.purpose, " ", "-"), ".", "-"))
  bucket_name = "${var.organisation}-${var.project}-${var.environment}-${local.purpose}-${random_password.bucket_suffix.result}"
}


resource "random_password" "bucket_suffix" {
  length  = var.bucket_suffix_length
  special = false
  upper   = false
}

resource "aws_s3_bucket" "this" {
  bucket = local.bucket_name
  tags = {
    Name        = local.bucket_name
    Environment = var.environment
    Project     = var.project
    Purpose     = var.purpose
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  dynamic "rule" {
    for_each = var.archive_days == null ? [] : [var.archive_days]

    content {
      id     = "archive-current"
      status = "Enabled"

      transition {
        days          = rule.value
        storage_class = "DEEP_ARCHIVE"
      }
    }
  }


  rule {
    id     = "expire-old-versions"
    status = "Enabled"

    noncurrent_version_transition {
      noncurrent_days = 5
      storage_class   = "DEEP_ARCHIVE"
    }

    noncurrent_version_expiration {
      noncurrent_days = var.noncurrent_version_expiration_days
    }
  }
}
