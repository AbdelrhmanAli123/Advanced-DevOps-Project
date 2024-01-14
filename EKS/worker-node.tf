
resource "aws_eks_node_group" "my_eks_node_group" {
  cluster_name    = aws_eks_cluster.my_eks.name
  node_group_name = var.nodes_configs.node_group_name
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
# subnet_ids    = values(aws_subnet.main)[*].id
  subnet_ids      = [for subnet_id in var.EKS_subnets_id : subnet_id]

  remote_access {
    ec2_ssh_key = var.nodes_configs.ec2_ssh_key
    source_security_group_ids = [var.sg_id]
  }

  scaling_config {
    desired_size = var.nodes_configs.desired_size
    max_size     = var.nodes_configs.max_size
    min_size     = var.nodes_configs.min_size
  }

  update_config {
    max_unavailable = 1
  }


  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}