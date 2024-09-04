resource "aws_s3_bucket" "state" {
  bucket = "137257-remote-state-terraform-rekproject"
  tags = var.comum_tags
}