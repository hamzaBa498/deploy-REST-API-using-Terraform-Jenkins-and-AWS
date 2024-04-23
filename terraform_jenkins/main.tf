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

module "jenkins" {
  source = "./jenkins"
  ami_id = var.ec2_ami_id
  instance_type = "t2.medium"
  tag_name = "Jenkins:Ubuntu Linux EC2"
  public_key = var.public_key
  subnet_id = tolist(module.networking.devops1_public_subnets_id)[0]
  sg_for_jenkins = [module.security_group.ec2_sg_ssh_http_https_id, module.security_group.ec2_jenkins_sg_id]
  enable_public_ip_address = true
  user_data_install_jenkins = templatefile("/jenkins-runner-script/jenkins-installer.sh",{})
}