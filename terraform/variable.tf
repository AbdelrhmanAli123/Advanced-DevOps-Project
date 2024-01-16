variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = number
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_tag_name" {
  type = string
}

variable "EKS_subnets_cidr" {
  type = map(string)
}

variable "RDS_subnets_cidr" {
  type = map(string)
}

variable "az" {
  type = list(any)
}

variable "sg-values" {
  type = object({

    name        = string
    description = string
    tag         = string
    cidr_ipv4   = string

  })
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


variable "ecr_info" {
  type = object({
    name                 = string
    force_delete         = bool
    image_tag_mutability = string
    scan_on_push         = bool
    countNumber          = number
  })
}


variable "rds_info" {
  type = object({
    allocated_storage       = number
    db_name                 = string
    engine                  = string
    engine_version          = string
    instance_class          = string
    username                = string
    password                = string
    subnet-group-name       = string
    backup_retention_period = number
    skip_final_snapshot     = bool
    # final_snapshot_identifier = string
    tag = string
  })
}



variable "namespaces" {
  type = list(string)
}


variable "ALB_info" {

  type = object({

    cluster_name  = string
    policy_name   = string
    iam_role_name = string
    namespace     = string
    sa_name       = string
    region        = string
  })

}