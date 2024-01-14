output "vpc_id" {
  value = aws_vpc.main.id
}


output "EKS_subnets_id" {
  
  value = [for subnets in aws_subnet.eks_subnets : subnets.id]

  # ------------------- another ways to get the output value --------------------------
  # value = {for key, subnet in aws_subnet.main : key => subnet.id}   "works with for each"
  # value = values(aws_subnet.main)[*].id # "works with for each"     "works with for each"
  # value = aws_subnet.main[*].id                                    "unsupported in for each "
}


output "RDS_subnets_id" {
  value = [for subnets in aws_subnet.rds_subnets : subnets.id]
}
