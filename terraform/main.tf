terraform {
  required_version = "1.6.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
    archive = {
      source = "hashicorp/archive"
      version = "2.5.0"
    }
    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
  }
  backend "s3" {
    bucket  = "137257-remote-state-terraform-celebrity-bot"
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

  website_name = var.website_name
  comum_tags = var.comum_tags
}

module "frontend" {
  source     = "./modules/frontend"

  depends_on = [ module.backend ]

  website_name = var.website_name
  comum_tags = var.comum_tags
  api_url = module.backend.api_url
}