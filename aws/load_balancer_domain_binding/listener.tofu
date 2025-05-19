locals {
  md5_hash         = md5(var.host)
  numeric_hash     = join("", [for c in split("", local.md5_hash) : c if can(regex("[0-9]", c))])
  default_priority = tonumber(substr(local.numeric_hash, 0, 6)) % 50000 + 1
  priority         = var.priority != null ? var.priority : local.default_priority
  url              = provider::netparse::parse_url(var.host)
  clean_host       = provider::netparse::parse_domain(local.url.host)
}

resource "aws_lb_listener_certificate" "this" {
  listener_arn    = var.listener_arn
  certificate_arn = var.certificate_arn
}

resource "aws_lb_listener_rule" "this" {
  listener_arn = var.listener_arn
  priority     = local.priority

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }

  condition {
    host_header {
      values = [local.clean_host.domain]
    }
  }
}
