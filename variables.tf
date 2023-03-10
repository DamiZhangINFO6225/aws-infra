variable "vpc_cidr_block" {
  type = string
}

variable "public_subnet_cidr_blocks" {
  type = list(string)
}

variable "private_subnet_cidr_blocks" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

provider "aws" {
  region = "us-west-2"
}
