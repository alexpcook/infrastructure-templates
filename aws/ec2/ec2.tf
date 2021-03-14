locals {
  total_azs = length(data.aws_availability_zones.available.names)
}

resource "aws_instance" "vm" {
  count = var.instances

  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet[data.aws_availability_zones.available.names[count.index % local.total_azs]].id
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name               = aws_key_pair.kp.key_name

  tags = {
    Name = format("%s-vm-%s", var.name_prefix, count.index)
  }
}

resource "aws_key_pair" "kp" {
  key_name   = format("%s-kp", var.name_prefix)
  public_key = file(var.public_key_file)

  tags = {
    Name = format("%s-kp", var.name_prefix)
  }
}