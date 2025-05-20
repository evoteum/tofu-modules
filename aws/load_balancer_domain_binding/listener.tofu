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
