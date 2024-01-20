# Specify the required providers
terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

# Configure the Kubernetes provider for EKS
provider "kubernetes" {
  host                   = module.EKS.endpoint
  cluster_ca_certificate = base64decode(module.EKS.certificate-authority-data)
  token                  = module.EKS.cluster_auth_token
}

# # Configure the Helm provider
provider "helm" {
  kubernetes {
    host                   = module.EKS.endpoint
    cluster_ca_certificate = base64decode(module.EKS.certificate-authority-data)
    token                  = module.EKS.cluster_auth_token
  }
}

