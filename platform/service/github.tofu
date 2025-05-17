locals {
  quay_repository_attributes = [
    "path",
    "url",
  ]

  quay_variables = {
    for attribute in local.quay_repository_attributes :
    "quay_repository_${attribute}" => {
      scope     = var.repository_name
      name      = "quay_repository_${attribute}"
      value     = lookup(module.quay_repository, attribute, null)
      sensitive = false
    }
  }

  cloudflare_zone_variables = {
    cloudflare_zone_id = {
      scope     = var.repository_name
      name      = "cloudflare_zone_id"
      value     = module.cloudflare_zone.id
      sensitive = true
    }
  }

  certificate_variables = {
    certificate_arn = {
      scope     = var.repository_name
      name      = "certificate_arn"
      value     = module.aws_certificate.certificate_arn
      sensitive = true
    }
  }

  all_github_variables = merge(
    local.certificate_variables,
    local.cloudflare_zone_variables,
    local.quay_variables,
  )

}


module "github_variable" {
  source   = "github.com/evoteum/tofu-modules//github/variable"
  for_each = local.all_github_variables

  sensitive = each.value.sensitive
  scope     = each.value.scope
  name      = each.value.name
  value     = each.value.value
}
