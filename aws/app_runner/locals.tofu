

locals {
  # Database ARNs
  has_dynamodb    = length([for arn in var.service_arns.databases : arn if can(regex("^arn:aws:dynamodb:", arn))]) > 0
  has_rds         = length([for arn in var.service_arns.databases : arn if can(regex("^arn:aws:rds:", arn))]) > 0
  has_elasticache = length([for arn in var.service_arns.databases : arn if can(regex("^arn:aws:elasticache:", arn))]) > 0

  dynamodb_arns    = [for arn in var.service_arns.databases : arn if can(regex("^arn:aws:dynamodb:", arn))]
  rds_arns         = [for arn in var.service_arns.databases : arn if can(regex("^arn:aws:rds:", arn))]
  elasticache_arns = [for arn in var.service_arns.databases : arn if can(regex("^arn:aws:elasticache:", arn))]

  # Storage ARNs
  has_s3  = length(var.service_arns.storage) > 0
  s3_arns = var.service_arns.storage

  # Secrets ARNs
  has_secrets_manager = length([for arn in var.service_arns.secrets : arn if can(regex("^arn:aws:secretsmanager:", arn))]) > 0
  has_ssm             = length([for arn in var.service_arns.secrets : arn if can(regex("^arn:aws:ssm:", arn))]) > 0

  secrets_manager_arns = [for arn in var.service_arns.secrets : arn if can(regex("^arn:aws:secretsmanager:", arn))]
  ssm_arns             = [for arn in var.service_arns.secrets : arn if can(regex("^arn:aws:ssm:", arn))]

  # Messaging ARNs
  has_sqs = length([for arn in var.service_arns.messaging : arn if can(regex("^arn:aws:sqs:", arn))]) > 0
  has_sns = length([for arn in var.service_arns.messaging : arn if can(regex("^arn:aws:sns:", arn))]) > 0

  sqs_arns = [for arn in var.service_arns.messaging : arn if can(regex("^arn:aws:sqs:", arn))]
  sns_arns = [for arn in var.service_arns.messaging : arn if can(regex("^arn:aws:sns:", arn))]

  # KMS ARNs
  has_kms  = length(var.service_arns.kms) > 0
  kms_arns = var.service_arns.kms
}
