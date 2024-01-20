output "ecr_name" {
  value = aws_ecr_repository.my_ecr.name
}

output "ecr_url" {
    value = aws_ecr_repository.my_ecr.repository_url 
}