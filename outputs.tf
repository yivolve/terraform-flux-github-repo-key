output "secret_name" {
  value       = aws_secretsmanager_secret.flux_secret.name
  description = "Secret name"
  sensitive   = true
}
