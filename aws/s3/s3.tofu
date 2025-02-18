locals {
    reversed_domain = join("-", reverse(split(".", var.org_domain)))
  purpose = lower(replace(replace(var.purpose, " ", "-"), ".", "-"))
    bucket_name = "${local.reversed_domain}-${var.project}-${var.environment}-${local.purpose}-${random_password.bucket_suffix.result}"
}

output "bucket_name" {
    value = local.bucket_name
  sensitive = true
}

output "bucket_name_length_is_good" {
    value = length(local.bucket_name) <= 63
}

resource "aws_s3_bucket" "bucket" {
    bucket = local.bucket_name
    tags = {
        Name        = local.bucket_name
        Environment = var.environment
        Project     = var.project
        Purpose     = var.purpose
    }
}