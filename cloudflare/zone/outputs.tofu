output "name_servers" {
  value = cloudflare_zone.this.name_servers
}

output "id" {
  value = cloudflare_zone.this.id
}