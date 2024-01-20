
// i decided to use ingress instead of ALB so this but i let this file as referance




// get account info
# data "aws_caller_identity" "aws_account_info" {}



# resource "aws_eks_identity_provider_config" "oidc" {
#   cluster_name                    = var.ALB_info.cluster_name
#   oidc {
#     client_id                     = "sts.amazonaws.com"
#     identity_provider_config_name = "DevOps"
#     issuer_url                    = var.oidc_issuer_url
#   }
# }

# data "http" "ALB_IAM_policy" {
#   url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json"
#   request_headers = {
#     Accept = "application/json"
#   }
# }


# resource "aws_iam_policy" "lbc_iam_policy" {
#   name        = var.ALB_info.policy_name
#   path        = "/"
#   description = "AWS ALB Controller IAM Policy"
#   policy      = data.http.ALB_IAM_policy.body
# }

# # Resource: Create IAM Role 
# resource "aws_iam_role" "lbc_iam_role" {
#   name = var.ALB_info.iam_role_name

#   # Terraform's "jsonencode" function converts a Terraform expression result to valid JSON syntax.
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           #edit_1
#           Federated = "arn:aws:iam::${data.aws_caller_identity.aws_account_info.account_id}:oidc-provider/${replace(var.oidc_issuer_url, "https://", "")}"
#         },
#         Action = "sts:AssumeRoleWithWebIdentity"
#         Condition = {
#           StringEquals = {
#             "${replace(var.oidc_issuer_url, "https://", "")}:aud" : "sts.amazonaws.com",
#             "${replace(var.oidc_issuer_url, "https://", "")}:sub" : "system:serviceaccount:${var.ALB_info.namespace}:${var.ALB_info.sa_name}"
#           }
#         }
#       },
#     ]
#   })

#   tags = {
#     tag-key = "AWSLoadBalancerControllerIAMPolicy"
#   }
# }

# # Associate Load Balanacer Controller IAM Policy to  IAM Role
# resource "aws_iam_role_policy_attachment" "lbc_iam_role_policy_attach" {
#   policy_arn = aws_iam_policy.lbc_iam_policy.arn
#   role       = aws_iam_role.lbc_iam_role.name
# }



# resource "helm_release" "loadbalancer_controller" {
#   depends_on = [aws_iam_role.lbc_iam_role, kubernetes_namespace.namespace]
#   name       = "aws-load-balancer-controller"
#   repository = "https://aws.github.io/eks-charts"
#   chart      = "aws-load-balancer-controller"
#   namespace  = var.ALB_info.namespace

#   set {
#     name  = "image.tag"
#     value = "v2.5.1"
#   }

#   set {
#     name  = "serviceAccount.create"
#     value = "true"
#   }

#   set {
#     name  = "serviceAccount.name"
#     value = var.ALB_info.sa_name
#   }

#   set {
#     name  = "service.type"
#     value = "LoadBalancer"
#   }


#   set {
#     name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
#     value = aws_iam_role.lbc_iam_role.arn
#   }

#   set {
#     name  = "vpcId"
#     value = var.vpc_id
#   }

#   set {
#     name  = "region"
#     value = var.ALB_info.region
#   }

#   set {
#     name  = "clusterName"
#     value = var.ALB_info.cluster_name
#   }

# }