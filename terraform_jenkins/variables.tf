variable "vpc_name" {
  type = string
  description = "DevOps project 1 Hamza"
}

variable "vpc_cidr" {
  type = string
  description = "Public subnet CIDR values"
}

variable "cidr_public_subnet" {
  type        = list(string)
  description = "Public Subnet CIDR values"
}

variable "cidr_private_subnet" {
  type        = list(string)
  description = "Private Subnet CIDR values"
}

variable "eu_availability_zone" {
  type        = list(string)
  description = "Availability Zones"
}

variable "public_key" {
  type        = string
  description = "DevOps Project 1 Public key for jenkins EC2 instance"
}

variable "ec2_ami_id" {
  type        = string
  description = "DevOps Project 1 AMI Id for jenkins EC2 instance"
}
