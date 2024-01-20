// VPC
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = var.vpc_tag_name
  }

}

// EKS subnets 
resource "aws_subnet" "eks_subnets" {
  for_each   = var.EKS_subnets_cidr
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
  map_public_ip_on_launch = true  # Enable auto-assign public IP, you probably get an error if it's not true
  availability_zone = var.az[index(keys(var.EKS_subnets_cidr), each.key) % length(var.az)]
  tags = {
    Name = each.key
  }
}



// Route Table
resource "aws_route_table" "eks_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "eks-route-table"
  }
}

resource "aws_route_table_association" "eks-route-table-association" {
  for_each       = var.EKS_subnets_cidr
  subnet_id      = aws_subnet.eks_subnets[each.key].id
  route_table_id = aws_route_table.eks_route_table.id
}

// Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}


// RDS subnets
resource "aws_subnet" "rds_subnets" {
  for_each   = var.RDS_subnets_cidr
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
  map_public_ip_on_launch = false  # Enable auto-assign public IP, you probably get an error if it's not true
  availability_zone = var.az[index(keys(var.RDS_subnets_cidr), each.key) % length(var.az)]


  tags = {
    Name = each.key
  }
}



// Route Table
resource "aws_route_table" "rds_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "rds_route_table"
  }
}

resource "aws_route_table_association" "rds-route-table-association" {
  for_each       = var.RDS_subnets_cidr
  subnet_id      = aws_subnet.rds_subnets[each.key].id
  route_table_id = aws_route_table.rds_route_table.id
}
