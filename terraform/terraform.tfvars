cluster_name    = "my-eks-cluster"
cluster_version = 1.27
vpc_cidr        = "10.0.0.0/16"
vpc_tag_name    = "my-vpc"

EKS_subnets_cidr = {
  "eks_subnet1" = "10.0.1.0/24",
  "eks_subnet2" = "10.0.2.0/24",
}

RDS_subnets_cidr = {
  "rds_subnet1" = "10.0.3.0/24",
  "rds_subnet2" = "10.0.5.0/24"
}

sg-values = {
  name        = "my-sg-eks"
  tag         = "eks-sg"
  description = "secuirty group for eks cluster"
  cidr_ipv4   = "0.0.0.0/0"
}

az = ["us-east-2a", "us-east-2b"]



nodes_configs = {
  desired_size    = 2
  max_size        = 3
  min_size        = 1
  node_group_name = "my-eks-node-group"
  ec2_ssh_key     = "myEKS"
}

ecr_info = {
  force_delete         = true
  name                 = "my-ecr"
  image_tag_mutability = "MUTABLE"
  scan_on_push         = true
  countNumber          = 2
}

rds_info = {
  allocated_storage       = 10
  db_name                 = "mydb"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t3.micro"
  username                = "ballo"
  password                = "123asd123asd"
  subnet-group-name       = "my-rds-group-name"
  backup_retention_period = 7
  skip_final_snapshot     = true
  # final_snapshot_identifier = "db-snapshot"
  tag = "rds-group-name"
}


namespaces = ["ingress", "argocd", "cert-manager"]

ALB_info = {
  cluster_name  = "my-eks-cluster"
  iam_role_name = "alb-role"
  namespace     = "alb"
  policy_name   = "alb-policy"
  sa_name       = "alb-service-account"
  region        = "us-east-2"
}