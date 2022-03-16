terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.5"
        }
    }
    required_version = "~> 1.1.6"
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

output "aws_security_group_id" {
    value = data.aws_vpc.default.id
    description = "Default VPC id"
}