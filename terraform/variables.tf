variable "region" {
  type    = string
  default = "us-east-1"
}

variable "comum_tags" {
  type = map(string)
  default = {
    "project"   = "celebrity-bot"
    "manegedBy" = "terraform"
  }
}