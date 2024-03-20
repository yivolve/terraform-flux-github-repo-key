resource "tls_private_key" "this" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "this" {
  title      = var.title
  repository = var.repository
  key        = tls_private_key.this.public_key_openssh
  read_only  = "false"
}

resource "aws_secretsmanager_secret" "this" {
  name                    = var.title
  description             = var.description
  recovery_window_in_days = 0
  tags                    = var.tags
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode(tls_private_key.this.private_key_pem)
  lifecycle {
    ignore_changes = [secret_string, ]
  }
}
