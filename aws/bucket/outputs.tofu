output "name_length_is_good" {
  description = "The character length of this bucket name is permissible"
  value       = length(local.bucket_name) <= 63
}

output "suffix" {
  description = "The secret suffix appended to the name of this bucket"
  value       = random_password.bucket_suffix.result
  sensitive   = true
}
