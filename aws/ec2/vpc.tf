data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.74.0.0/16"
  tags = {
    Name = format("%s-vpc", var.name_prefix)
  }
}