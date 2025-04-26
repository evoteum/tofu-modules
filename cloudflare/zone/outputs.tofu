output "name_servers" {
  value = cloudflare_zone.this.name_servers
}

output "id" {
  description = "The Cloudflare zone ID"
  value       = cloudflare_zone.this.id
}

output "zone" {
  description = "The name of the zone we are managing"
  value = cloudflare_zone.this.zone
}