output "ec2_public_ip" {
  value = {
    for key, instance in aws_instance.vm : key => instance.public_ip
  }
}