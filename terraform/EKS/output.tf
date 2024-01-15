output "endpoint" {
  value = aws_eks_cluster.my_eks.endpoint
  description = "EKS cluster endpoint"
}

output "certificate-authority-data" {
  value = aws_eks_cluster.my_eks.certificate_authority[0].data
  description = "EKS cluster certificate authority data"
}


output "cluster_auth_token" {
  
  value = data.aws_eks_cluster_auth.cluster_token.token
  description = "EKS cluster authentication token"
}


output "oidc_issuer_url" {
  value = aws_eks_cluster.my_eks.identity[0].oidc[0].issuer
}

