output "alb_arn" {
  value = aws_lb.this.arn
}

output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "https_listener_arn" {
  value = aws_lb_listener.https.arn
}

output "alb_zone_id" {
  value       = aws_lb.this.zone_id
  description = "The canonical hosted zone ID of the load balancer (useful for DNS records)"
}