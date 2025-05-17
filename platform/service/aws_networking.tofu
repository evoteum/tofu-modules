module "aws_certificate" {
  source = "github.com/evoteum/tofu-modules//aws/certificate"

  domain_name = var.homepage_url
}


resource "aws_acm_certificate_validation" "this" {
  certificate_arn = module.aws_certificate.certificate_arn

  validation_record_fqdns = [
    for dvo in values(module.aws_certificate.domain_validation_options) :
    dvo.name
  ]

  depends_on = [
    module.aws_certificate,
    module.cloudflare_record,
    module.cloudflare_zone,
  ]
}


module "aws_load_balancer_domain_binding" {
  source = "github.com/evoteum/tofu-modules//aws/load_balancer_domain_binding"

  certificate_arn  = module.aws_certificate.certificate_arn
  listener_arn     = var.listener_arn
  target_group_arn = module.aws_ecs_service.target_group_arn
  host             = var.homepage_url
  priority         = var.priority

  depends_on = [
    module.aws_certificate,
    module.aws_ecs_service,
  ]
}
