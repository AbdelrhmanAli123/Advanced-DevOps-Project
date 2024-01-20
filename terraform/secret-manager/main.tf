resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&"
}


resource "aws_kms_key" "kms" {
  description = "KMS key for RDS"
  is_enabled = true
  enable_key_rotation = true

  tags = {
    Name = "KMS_RDS"
  }
}

resource "aws_secretsmanager_secret" "secret-manager" {
  name = "my-secret-manager"
  kms_key_id = aws_kms_key.kms.id
  tags = {
    Name = "terraform secret manager"
  }


}



resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.secret-manager.id
  secret_string = random_password.password.result
}