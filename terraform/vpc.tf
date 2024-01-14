# resource "aws_vpc" "main" {
#   cidr_block       = var.vpc_cidr
#   instance_tenancy = "default"
#   tags = {
#     Name = var.vpc_tag_name
#   }

# }