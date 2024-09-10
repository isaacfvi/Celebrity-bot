variable "comum_tags" {
  type = map(string)
}

variable "website_name" {
  type    = string
}

variable "lambda_path" {
  type    = string
  default = "../backend"
}