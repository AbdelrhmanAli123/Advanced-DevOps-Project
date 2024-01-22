resource "aws_security_group" "my-eks-sg" {
  name        = var.sg-values.name
  description = var.sg-values.description
  vpc_id      = var.vpc_id

  tags = {
    Name = var.sg-values.tag
  }
}

//I am allowing all the inbound traffic for all ports, just for sake of simplicity
resource "aws_vpc_security_group_ingress_rule" "allow_all_inbound_ipv4" {
  security_group_id = aws_security_group.my-eks-sg.id
  cidr_ipv4         = var.sg-values.cidr_ipv4
  from_port         = 0
  to_port           = 65500
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_ipv4" {
  security_group_id = aws_security_group.my-eks-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

