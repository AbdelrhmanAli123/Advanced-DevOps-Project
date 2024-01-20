module "Network" {
  source           = "/home/ballo/terra/terraform/network"
  vpc_cidr         = var.vpc_cidr
  vpc_tag_name     = var.vpc_tag_name
  EKS_subnets_cidr = var.EKS_subnets_cidr
  RDS_subnets_cidr = var.RDS_subnets_cidr
  az               = var.az
}
