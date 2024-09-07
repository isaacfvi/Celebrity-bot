variable "comum_tags" {
  type = map(string)
}

variable "website_files" {
  type = map(string)
  default = {
    "index.html" = "../frontend/index.html"
    "index.js"   = "../frontend/index.js"
    "style.css"  = "../frontend/style.css"
  }
}