output "db_name" {
  value = module.RDS.db_name
}

output "db_endpoint" {
  value = module.RDS.endpoint
}

output "ecr_name" {
  value = module.ECR.ecr_name
}

output "ecr_url" {
  value = module.ECR.ecr_url
}