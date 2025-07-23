terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.4.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

resource "random_id" "randomid" {
  byte_length = 8
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "demo-bucket" { // this code to create S3 bucket
    bucket = "demo-s3-bucket-${random_id.randomid.hex}"
     force_destroy = true
}

resource "aws_s3_object" "Website-content-in-bucket"{
    bucket = aws_s3_bucket.demo-bucket.bucket
    source = "./index.txt"
    key = "mydata.txt"

}

output "name" {
  value = random_id.randomid.hex


}

