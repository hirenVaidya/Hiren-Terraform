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

resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my-vpc"
    }
}

#public subnet

resource "aws_subnet" "public-subnet" {
    cidr_block  = "10.0.2.0/24"
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        name ="public-subnet"
    }
}

# Private subnet

resource "aws_subnet" "private-subnet" {
    cidr_block  = "10.0.1.0/24"
    vpc_id = aws_vpc.my-vpc.id
  tags = {
    name = "private-subnet"
  }
}



# internet gateway
resource "aws_internet_gateway" "my-igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "my-igw"
    }
}

# route table for public subnet
resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-vpc.id  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
}
}

resource "aws_route_table_association" "public-subnet-ass" {
  subnet_id = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_instance" "myserver" {
    ami = "ami-0f918f7e67a3323f0"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public-subnet.id

tags = {
 Name = "SampleServer"
}  
}