# ec2-deployer

This Terraform module creates an AWS VPC, Internet gateway, subnets, route tables, network access control lists (NACLs), and security groups. It then deploys a configurable number of EC2 instances to the VPC using a desired AMI. This is suitable for getting one or more EC2 instances running on AWS with the capability to SSH into them from a configurable public IP address.

Except for the public IP address from which to allow inbound SSH traffic in the security group, the other details of the VPC are abstracted away by the module. Subnets are created in every healthy availability zone in the AWS region of the deployment and allow public access to them. EC2 instances can reach the Internet via security group, NACL, and Internet gateway configuration.

The key pair used for SSH to the EC2 instances is configurable. All instances are the t2.micro instance type. Instances are placed into available subnets in a round-robin fashion to ensure as close to even spread among multiple AZs.
