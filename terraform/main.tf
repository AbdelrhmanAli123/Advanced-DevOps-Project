module "Network" {
  source           = "/home/ballo/terra/terraform/network"
  vpc_cidr         = var.vpc_cidr
  vpc_tag_name     = var.vpc_tag_name
  EKS_subnets_cidr = var.EKS_subnets_cidr
  RDS_subnets_cidr = var.RDS_subnets_cidr
  az               = var.az
}

module "SG" {
  source           = "/home/ballo/terra/terraform/SG"
  vpc_id           = module.Network.vpc_id
  sg-values        = var.sg-values
}

module "EKS" {
  source           = "/home/ballo/terra/terraform/EKS"
  cluster_name     = var.cluster_name
  EKS_subnets_id   = module.Network.EKS_subnets_id
  sg_id            = module.SG.sg_id
  nodes_configs    = var.nodes_configs
}

module "ECR" {
  source           = "/home/ballo/terra/terraform/ECR"
  ecr_info         = var.ecr_info
}

module "RDS" {
  source           = "/home/ballo/terra/terraform/RDS"
  RDS_subnets_id   = module.Network.RDS_subnets_id
  sg_id            = module.SG.sg_id
  rds_info         = var.rds_info
}

module "K8S-oprators" {
  source          = "/home/ballo/terra/terraform/K8S-oprator"
  namespaces      = var.namespaces
  ALB_info        = var.ALB_info
  oidc_issuer_url = module.EKS.oidc_issuer_url
  vpc_id          = module.Network.vpc_id
  
}