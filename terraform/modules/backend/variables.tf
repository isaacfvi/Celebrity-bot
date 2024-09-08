variable "comum_tags" {
  type = map(string)
}

variable "lambda_path" {
  type    = string
  default = "../backend"
}