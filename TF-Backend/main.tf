
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.4.0"
    }
  }
  backend "s3" {
    bucket = "demo-s3-bucket-12b23d7e9a10d427"
    key    = "backend.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "myserver" {
    ami = "ami-0f918f7e67a3323f0"
    instance_type = "t2.micro"

    tags = {
        Name = "SampleServer"
    }  

}
