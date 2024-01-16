# data "aws_secretsmanager_secret" "secret-manager-data" {

#   name = "my-secret-manager"
  
# }

# data "aws_secretsmanager_secret_version" "secret-manager-version" {
#   secret_id = data.aws_secretsmanager_secret.secret-manager-data.id
  
# }
resource "aws_db_instance" "my_rds" {
  depends_on                = [ aws_db_subnet_group.subnet-group ]
  allocated_storage         = var.rds_info.allocated_storage
  db_name                   = var.rds_info.db_name
  engine                    = var.rds_info.engine
  engine_version            = var.rds_info.engine_version
  instance_class            = var.rds_info.instance_class
  username                  = var.rds_info.username
  # password                  = data.aws_secretsmanager_secret_version.secret-manager-version.secret_string
  password                  = var.rds_info.password

  backup_retention_period   = var.rds_info.backup_retention_period
  skip_final_snapshot       = var.rds_info.skip_final_snapshot
  # final_snapshot_identifier = var.rds_info.final_snapshot_identifier
  vpc_security_group_ids    = [ var.sg_id ]
  db_subnet_group_name      = aws_db_subnet_group.subnet-group.name
}

resource "aws_db_subnet_group" "subnet-group" {
  name       = var.rds_info.subnet-group-name
  subnet_ids = [for subnet_id in var.RDS_subnets_id : subnet_id]

  tags = {
    Name = var.rds_info.tag
  }
}