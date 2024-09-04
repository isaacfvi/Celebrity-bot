terraform {
  required_version = "1.6.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
  }
  backend "s3" {
    bucket  = "137257-remote-state-terraform-rekproject"
    key     = "remote-state"
    region  = "us-east-1"
    profile = "tf-user"
  }

}

provider "aws" {
  region  = var.region
  profile = "tf-user"
}

module "backend" {
  source     = "./modules/backend"
  comum_tags = var.comum_tags
}

module "frontend" {
  source = "./modules/frontend"
}