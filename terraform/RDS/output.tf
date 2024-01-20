output "db_name" {
  value = aws_db_instance.my_rds.db_name
}
output "endpoint" {
  value = aws_db_instance.my_rds.endpoint
}