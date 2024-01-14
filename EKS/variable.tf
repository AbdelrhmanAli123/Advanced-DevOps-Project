variable "cluster_name" {
  type = string
}

variable "EKS_subnets_id" {
  type = list(string)
}

variable "sg_id" {
  type = string
}

variable "nodes_configs" {
    
    type = object({
      desired_size    = number
      max_size        = number
      min_size        = number
      node_group_name = string
      ec2_ssh_key     = string
    })
  
}


