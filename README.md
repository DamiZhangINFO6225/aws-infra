# aws-infra
AWS Networking Setup using Terraform
This Terraform configuration creates a basic AWS Networking Setup, including a VPC, 3 public subnets, 3 private subnets, an internet gateway, and route tables for both public and private subnets.

Usage
Create a variables file (e.g. variables.tfvars) and define the following variables:
region: the region you want to create your VPC and subnets in (e.g. "us-west-2")
vpc_cidr: the CIDR block for your VPC (e.g. "10.0.0.0/16")
public_subnet_cidrs: a list of 3 CIDR blocks for your public subnets (e.g. ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"])
private_subnet_cidrs: a list of 3 CIDR blocks for your private subnets (e.g. ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"])
Create a main.tf file and define the following resources:
Provider: the AWS provider for Terraform
VPC: the VPC resource with the defined CIDR block
Public subnets: the 3 public subnets with the defined CIDR blocks and availability zones
Private subnets: the 3 private subnets with the defined CIDR blocks and availability zones
Internet Gateway: the internet gateway resource attached to the VPC
Public route table: the public route table with a default route to the internet gateway and the 3 public subnets associated
Private route table: the private route table with the 3 private subnets associated
Initialize the Terraform environment:
csharp
Copy code
terraform init
See a plan of what resources will be created:
javascript
Copy code
terraform plan -var-file="variables.tfvars"
Apply those changes to your AWS account:
javascript
Copy code
terraform apply -var-file="variables.tfvars"
When you're done, destroy the resources created:
javascript
Copy code
terraform destroy -var-file="variables.tfvars"
Notes
The CIDR blocks used for the VPC and subnets should not overlap with any existing CIDR blocks in your AWS account.
