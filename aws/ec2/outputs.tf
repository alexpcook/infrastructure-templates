output "ec2_ip_addrs" {
  value = {
    for key, instance in aws_instance.vm : key => instance.public_ip
  }
}