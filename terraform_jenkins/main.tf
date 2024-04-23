module "networking"{
    source = "./networking"
    vpc_cidr = var.vpc_cidr
    vpc_name = var.vpc_name
    cidr_public_subnet = var.cidr_public_subnet
    cidr_private_subnet = var.cidr_private_subnet
    eu_availability_zone = var.eu_availability_zone
}


module "security_group" {
  source = "./security_group"
  ec2_sg_name = "Security Group for EC2 machine to enable SSH(22), HTTPS(443), HTTP(8080) and HTTP(80)"
  vpc_id = module.networking.devops_project1_vpc_id
  ec2_jenkins_sg_name = "Allow port 8080 for jenkins"
}
