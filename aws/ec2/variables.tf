variable "aws_profile" {
  description = "The AWS profile to deploy the EC2 instances to. Default is 'default'."
  type        = string
  default     = "default"
}

variable "aws_region" {
  description = "The AWS region to deploy the EC2 instances to."
  type        = string
}
