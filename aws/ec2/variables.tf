variable "aws_profile" {
  description = "The AWS profile to deploy the EC2 instances to."
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy the EC2 instances to."
  type        = string
}

variable "name_prefix" {
  description = "The naming prefix to apply to AWS resources. Default is 'apc-ec2'."
  type        = string
  default     = "apc-ec2"
}

variable "public_ip" {
  description = "The public IP address from which to allow SSH traffic to the EC2 instances."
  type        = string
  sensitive   = true
}