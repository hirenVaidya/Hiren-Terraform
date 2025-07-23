
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "myserver" {
    ami = "ami-0f918f7e67a3323f0"
    instance_type = "t2.micro"

tags = {
 Name = "SampleServer"
}  
}

