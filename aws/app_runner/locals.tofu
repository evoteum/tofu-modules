locals {
  has_dynamodb = length([for arn in var.service_arns.databases : arn if can(regex("^arn:aws:dynamodb:", arn))]) > 0

  dynamodb_arns = [for arn in var.service_arns.databases : arn if can(regex("^arn:aws:dynamodb:", arn))]

  resource_prefix = "${var.project_name}-${var.environment}"

  is_custom_vpc = var.vpc_connector_arn == null ? false : true

  is_github_source = can(regex("github\\.com", var.application_source_uri))
  is_ecr_source    = can(regex("public\\.ecr\\.aws", var.application_source_uri))

  is_container_source = local.is_ecr_source
  is_code_source      = local.is_github_source

  runtime_map = {
    "python:3"    = "PYTHON_3"
    "nodejs:12"   = "NODEJS_12"
    "nodejs:14"   = "NODEJS_14"
    "nodejs:16"   = "NODEJS_16"
    "corretto:8"  = "CORRETTO_8"
    "corretto:11" = "CORRETTO_11"
    "go:1"        = "GO_1"
    "dotnet:6"    = "DOTNET_6"
    "php:81"      = "PHP_81"
    "ruby:31"     = "RUBY_31"
  }

  cleaned_version = replace(var.runtime.version, "^v", "")
  major_version   = split(".", local.cleaned_version)[0]

  runtime_key = "${lower(var.runtime.language)}:${local.major_version}"

  apprunner_runtime = lookup(local.runtime_map, local.runtime_key, null)

  enable_dynamodb = anytrue([
    for arn in var.service_arns.databases : contains(arn, "dynamodb")
  ])

  custom_domain_parsed = provider::netparse::parse_url(var.custom_domain)
}
