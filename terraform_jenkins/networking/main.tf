variable "vpc_cidr" {}
variable "vpc_name" {}
variable "eu_availability_zone" {}
variable "cidr_public_subnet" {}
variable "cidr_private_subnet" {}


# Setup Virtual Private Cloud (VPC) : ressource "ressource_name" "custom_name"
resource "aws_vpc" "devops_project1_hamza" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# Setup Public Subnets
resource "aws_subnet" "devops1_public_subnets_hamza" {
  count = length(var.cidr_public_subnet)
  vpc_id = aws_vpc.devops_project1_hamza.id
  cidr_block = element(var.cidr_public_subnet,count.index)
  availability_zone = element(var.eu_availability_zone,count.index)

  tags = {
    Name = "devops1-public-subnet-${count.index +1}_hamza"
  }
}

# Setup Private Subnets
resource "aws_subnet" "devops1_private_subnets_hamza" {
  count = length(var.cidr_private_subnet)
  vpc_id = aws_vpc.devops_project1_hamza.id
  cidr_block = element(var.cidr_private_subnet,count.index)
  availability_zone = element(var.eu_availability_zone,count.index)

  tags = {
    Name = "devops1-private-subnet-${count.index +1}_hamza"
  }
}