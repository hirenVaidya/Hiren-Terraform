terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.4.0"
    }
  }
}

provider "aws" {
    region = "ap-south-1" 
}

data "aws_ami" "name" {
   most_recent = true
   owners = ["amazon"]
}

data "aws_security_group" "name" {
  tags = {
    myserver = "http"
  }
}
data "aws_availability_zones" "names"{
        state = "available"
}
output "aws_zone" {
 value = data.aws_availability_zones.names
  
}

data "aws_vpc" "name"{
  tags = {
    Env = "Pro"
  }
}   

data "aws_subnet" "name" {
    filter {
      name = "vpc-id"
      values =  [data.aws_vpc.name.id]
    }
    tags = {
      Name = "private-subnet"
    }
}

output "vpc_id" {
    value = data.aws_vpc.name.id
}

data "aws_caller_identity" "name"{

}

output "caller-Info" {
    value =  data.aws_caller_identity.name 
}

output "aws_security_group" {
    value = data.aws_security_group.name.id
  
}
output "aws_ami" {

  value = data.aws_ami.name.id
}

resource "aws_instance" "name" {
    ami = "ami-0f918f7e67a3323f0"
    instance_type = "t2.micro"
    subnet_id = data.aws_subnet.name.id
    security_groups = [data.aws_security_group.name]
    tags = {
    Name = "sampleserver"
    }
}