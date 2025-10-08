terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.4.3"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "nitinda"

    workspaces {
      name = "learn-terraform-github-actions"
    }
  }
}


provider "aws" {
  region = "eu-west-2"
}

resource "random_pet" "sg" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


output "ami_id" {
    description = "ID of the AMI."
    value = data.aws_ami.ubuntu.id  
}

output "name" {
    description = "Name of the AMI that was provided during image creation."
    value = data.aws_ami.ubuntu.name  
}
