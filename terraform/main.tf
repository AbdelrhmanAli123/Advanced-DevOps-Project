module "Network" {
  source           = "./network"
  vpc_cidr         = var.vpc_cidr
  vpc_tag_name     = var.vpc_tag_name
  EKS_subnets_cidr = var.EKS_subnets_cidr
  RDS_subnets_cidr = var.RDS_subnets_cidr
  az               = var.az
}


module "SG" {
  source    = "./SG"
  vpc_id    = module.Network.vpc_id
  sg-values = var.sg-values
}

module "EKS" {
  source         = "./EKS"
  cluster_name   = var.cluster_name
  EKS_subnets_id = module.Network.EKS_subnets_id
  sg_id          = module.SG.sg_id
  nodes_configs  = var.nodes_configs
}

module "ECR" {
  source   = "./ECR"
  ecr_info = var.ecr_info
}

# module "secret-manager" {
#   source = "./secret-manager"

# }

module "RDS" {
  source         = "./RDS"
  RDS_subnets_id = module.Network.RDS_subnets_id
  sg_id          = module.SG.sg_id
  rds_info       = var.rds_info
}

module "oidc_issuer_url" {
  source         = "./oidc-role"
  eks_issuer_url = module.EKS.oidc_issuer_url
}

module "K8S-oprators" {
  source     = "./K8S-oprator"
  namespaces = var.namespaces
  vpc_id     = module.Network.vpc_id
} 