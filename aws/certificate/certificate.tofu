resource "aws_acm_certificate" "this" {
  domain_name               = local.domain_name_host
  subject_alternative_names = local.subject_alternative_names_host
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}
