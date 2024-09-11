variable "region" {
  type    = string
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