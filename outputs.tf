output "secret_name" {
  value     = aws_secretsmanager_secret.flux_secret.name
  sensitive = true
}
