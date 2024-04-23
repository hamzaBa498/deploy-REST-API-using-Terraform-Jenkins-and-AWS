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

# Setup Internet Gateway : to allow internet access to all created ressources and to let them be accessible from internet
resource "aws_internet_gateway" "devops1_public_internet_gateway_hamza" {
  vpc_id = aws_vpc.devops_project1_hamza.id
  tags = {
    Name = "devops_project1_igw"
  }
}

# Setup public Route table
resource "aws_route_table" "devops_public_route_tables_hamza" {
  vpc_id = aws_vpc.devops_project1_hamza.id
  route {
    cidr_block = "0.0.0.0/0" #internet request
    gateway_id = aws_internet_gateway.devops1_public_internet_gateway_hamza.id
  }
  tags = {
    Name = "devops_project1_public_rt_hamza"
  }
}

# Setup private Route table
resource "aws_route_table" "devops_private_route_tables_hamza" {
  vpc_id = aws_vpc.devops_project1_hamza.id

  tags = {
    Name = "devops_project1_private_rt_hamza"
  }
}