resource "aws_eks_cluster" "my_eks" {

  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn


  vpc_config {
    # subnet_ids = values(aws_subnet.main)[*].id
    subnet_ids = [ for subnet_id in var.EKS_subnets_id : subnet_id ]
    security_group_ids = [ var.sg_id ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
 
  depends_on = [
    aws_iam_role_policy_attachment.Amazon_EKS_Cluster_Policy,
  ]
}

data "aws_eks_cluster_auth" "cluster_token" {
  name = aws_eks_cluster.my_eks.name
}


