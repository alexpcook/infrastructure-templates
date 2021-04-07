# ec2-deployer

This Terraform module creates an AWS VPC, Internet gateway, subnets, route tables, network access control lists (NACLs), and security groups. It then deploys a configurable number of EC2 instances to the VPC using a desired AMI. This is suitable for getting one or more EC2 instances running on AWS with the capability to SSH into them from a configurable public IP address.

Except for the public IP address from which to allow inbound SSH traffic in the security group, the other details of the VPC are abstracted away by the module. Subnets are created in every healthy availability zone in the AWS region of the deployment and allow public access to them. EC2 instances can reach the Internet via security group, NACL, and Internet gateway configuration.

The key pair used for SSH to the EC2 instances is configurable. All instances are the t2.micro instance type. Instances are placed into available subnets in a round-robin fashion to ensure as close to even spread among multiple AZs.

## Requirements

An AWS IAM service account with an access key, secret key, and appropriate administrator credentials is needed to create and destroy the resources in this module.

The public IP address desired for SSH traffic to the instances must also be known. This can be found through various websites and APIs, e.g.

`curl https://api.ipify.org`

The AWS AMI ID must also be known for the region of the deployment. This can be found in the [AWS Management Console or via the AWS CLI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html), e.g.

`aws ec2 describe-images --owners self amazon --region us-west-1 --filters "Name=..., Values=..."`

Finally, a public key file for SSH must also be available. These can be created in a number of ways, e.g.

`ssh-keygen -t rsa -b 2048 -f path/to/private/key`

## Inputs

`aws_profile` - The AWS profile to use for the deployment. The value to use depends on the format of your [AWS credentials file](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) ('default' should work fine for most users).

`aws_region` - The AWS region to deploy the infrastructure to (e.g. us-west-1).

`name_prefix` - A naming prefix to apply to all resources created via the module.

`public_ip` - The public IPv4 address from which to allow SSH traffic to the EC2 instances.

`ami_id` - The AWS AMI ID to use for the instances. Note that these are region-specific.

`public_key_file` - The public key file to use for SSH to the instances.

`user_data_script` - The user data script to run upon bootstrapping the instances.

`instances` - The number of EC2 instances to provision.

## Outputs

`ec2_ip_addrs` - A map of public IP addresses of the EC2 instances.
