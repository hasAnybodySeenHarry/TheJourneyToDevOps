resource "aws_secretsmanager_secret" "db_secret" {
  name = "tools_db_cred"
}

resource "aws_secretsmanager_secret_version" "db_secret_v1" {
  secret_id = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    db_user     = aws_db_instance.app_db.username,
    db_password = aws_db_instance.app_db.password,
    db_endpoint = aws_db_instance.app_db.endpoint,
    db_name     = aws_db_instance.app_db.db_name,
  })
}
