output "secret_name" {
  value       = aws_secretsmanager_secret.this.name
  description = "Secret name"
  sensitive   = true
}
