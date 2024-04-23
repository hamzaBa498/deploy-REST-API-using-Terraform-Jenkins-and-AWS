variable "ec2_sg_name" {}
variable "vpc_id" {}
variable "ec2_jenkins_sg_name" {}

output "ec2_sg_ssh_http_https_id" {
  value = aws_security_group.ec2_sg_ssh_http_https.id
}

output "ec2_jenkins_sg_id" {
  value = aws_security_group.ec2_jenkins_sg_port_8080.id
}
resource "aws_security_group" "ec2_sg_ssh_http_https" {
    name = var.ec2_sg_name
    description = "Enable the port 22(ssh) & 443(https) & Port 80(hhtp)"
    vpc_id = var.vpc_id

   # SSH for terraform remote execution
   ingress {
    description = "Allow remote SSH from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
   }

   # Enable http
   ingress {
    description = "Allow HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    to_port = 80
    protocol = "tcp"
   }

   # Enable https
   ingress {
    description = "Allow HTTPS request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 443
    to_port = 443
    protocol = "tcp"
   }

   # Outgoing request
   egress {
    description = "Allow outgoing request"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
   }

    tags = {
        Name = "Security group to allow port 22, 443 and 80"
    }
}

resource "aws_security_group" "ec2_jenkins_sg_port_8080" {
  name = var.ec2_jenkins_sg_name
  description = "Enable the port 8080 for jenkins"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow port 8080 to access jenkins"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
  }

  tags = {
    Name = "Security group to allow port 8080"
  }
}