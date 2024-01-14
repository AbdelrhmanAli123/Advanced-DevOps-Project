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
  type = list
}

