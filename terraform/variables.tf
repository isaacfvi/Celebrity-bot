variable "region" {
  type    = string
  default = "us-east-1"
}

variable "website_name" {
  type    = string
  default = "celebrity-bot"
}

variable "comum_tags" {
  type = map(string)
  default = {
    "project"   = "celebrity-bot"
    "manegedBy" = "terraform"
  }
}