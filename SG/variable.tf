variable "sg-values" {
  type = object({

    name        = string
    description = string
    tag         = string
    cidr_ipv4   = string

  })
}

variable "vpc_id" {
  type = string
}