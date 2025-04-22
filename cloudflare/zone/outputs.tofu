output "name_servers" {
  value = cloudflare_zone.service.name_servers
}

output "id" {
  description = "The Cloudflare zone ID"
  value       = cloudflare_zone.service.id
}