data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.74.0.0/16"

  tags = {
    Name = format("%s-vpc", var.name_prefix)
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = format("%s-igw", var.name_prefix)
  }
}

resource "aws_default_route_table" "rtb" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route = [{
    cidr_block                = "0.0.0.0/0"
    egress_only_gateway_id    = null
    gateway_id                = aws_internet_gateway.igw.id
    instance_id               = null
    ipv6_cidr_block           = null
    nat_gateway_id            = null
    network_interface_id      = null
    transit_gateway_id        = null
    vpc_endpoint_id           = null
    vpc_peering_connection_id = null
  }]

  tags = {
    Name = format("%s-rtb", var.name_prefix)
  }
}

resource "aws_route_table_association" "rtba" {
  for_each = aws_subnet.subnet

  route_table_id = aws_default_route_table.rtb.id
  subnet_id      = each.value.id
}

resource "aws_default_network_acl" "nacl" {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id
  subnet_ids = [
    for subnet in aws_subnet.subnet : subnet.id
  ]

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = format("%s-nacl", var.name_prefix)
  }
}

resource "aws_subnet" "subnet" {
  for_each = {
    for i, az in data.aws_availability_zones.available.names : az => i
  }

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = format("10.74.%s.0/24", each.value + 1)
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    Name = format("%s-subnet-%s", var.name_prefix, each.value + 1)
  }
}