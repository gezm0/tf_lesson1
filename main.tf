terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.5"
        }
    }
    required_version = "~> 1.0"
}

provider "aws" {
    region = "eu-west-2"
}

data "aws_vpc" "default" {
    default = true
}

data "aws_security_group" "Default_VPC" {
    vpc_id = data.aws_vpc.default.id

filter {
    name   = "group-name"
    values = ["default"]
    }
}

output "aws_default_vpc_id" {
    value = data.aws_vpc.default.id
    description = "Default VPC id"
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_subnet" "default" {
    for_each = toset(data.aws_subnets.default.ids)
    id       = each.value
}

output "subnet_cidr_blocks" {
    value = [for s in data.aws_subnet.default : s.cidr_block]
    description = "My subnets"
}

data "aws_security_groups" "default" {
filter {
    name   = "group-name"
    values = ["default"]
    }
}

output "aws_security_groups" {
    value = data.aws_security_groups.default.ids
    description = "Default security groups"
}