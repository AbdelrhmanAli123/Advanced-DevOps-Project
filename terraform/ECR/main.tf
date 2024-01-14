resource "aws_ecr_repository" "my_ecr" {
  name                 = var.ecr_info.name
  image_tag_mutability = var.ecr_info.image_tag_mutability
  force_delete = var.ecr_info.force_delete
  image_scanning_configuration {
    scan_on_push = var.ecr_info.scan_on_push
  }
}

resource "aws_ecr_lifecycle_policy" "foopolicy" {
  repository = aws_ecr_repository.my_ecr.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 14 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 2
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
