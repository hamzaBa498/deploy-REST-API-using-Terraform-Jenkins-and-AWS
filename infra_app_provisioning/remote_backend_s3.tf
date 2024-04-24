terraform {
  backend "s3" {
    bucket = "terraform-logs-hamza-devops"
    key    = "devops-project-1/terraform.tfstate"
    region = "eu-central-1"
  }
}