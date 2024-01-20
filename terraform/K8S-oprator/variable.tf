variable "namespaces" {
  type = list(string)
}


variable "vpc_id" {
  type = string
}

# variable "Cert-manager" {
#   type = object({
#     name = string
#   })

# }



# variable "Nginx_ingres_info" {
#   type = object({
#     name = string
#   })
  
# }




# variable "ArgoCD_info" {
#   type = object({
#     name = string
#   })
# }

# variable "ALB_info" {
  
#   type = object({

#     cluster_name            = string
#     policy_name             = string
#     iam_role_name           = string
#     namespace               = string
#     sa_name                 = string
#     region                  = string    
#   })
  
# }

# variable "oidc_issuer_url" {
#   type = string
  
# }
