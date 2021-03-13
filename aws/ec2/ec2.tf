resource "aws_instance" "vm" {
  for_each = aws_subnet.subnet

  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = each.value.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name               = aws_key_pair.kp.key_name

  tags = {
    Name = format("%s-vm", var.name_prefix)
  }
}

resource "aws_key_pair" "kp" {
  key_name   = format("%s-kp", var.name_prefix)
  public_key = file(var.public_key_file)

  tags = {
    Name = format("%s-kp", var.name_prefix)
  }
}