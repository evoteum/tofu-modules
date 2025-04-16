locals {
  resource_prefix = "${var.project_name}-${var.environment}"

  is_code_source      = var.github_repository != "" && var.ecr_repository == ""
  is_container_source = var.ecr_repository != "" && var.github_repository == ""

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

  enable_dynamodb   = length(var.dynamodb_arns) > 0
  enable_ecr        = length(var.ecr_arns) > 0
  enable_custom_vpc = var.vpc_connector_arn == "" ? false : true

  cleaned_version = replace(var.runtime.version, "^v", "")
  major_version   = split(".", local.cleaned_version)[0]

  runtime_key = "${lower(var.runtime.language)}:${local.major_version}"

  apprunner_runtime = lookup(local.runtime_map, local.runtime_key, null)

  custom_domain_parsed = provider::netparse::parse_url(var.custom_domain)
}
