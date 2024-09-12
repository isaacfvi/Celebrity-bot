module "template_files" {
  source = "hashicorp/dir/template"
  base_dir = "../frontend"
}

resource "aws_s3_bucket" "website" {
  bucket = var.website_name
  tags   = var.comum_tags
}

resource "aws_s3_object" "website" {
  for_each = module.template_files.files
  bucket   = aws_s3_bucket.website.id
  key      = each.key
  source   = each.key == "index.html" ? null : each.value.source_path
  content = each.key == "index.html" ? templatefile(each.value.source_path, {API_URL = var.api_url}) : null
  etag = each.key == "index.html" ? md5(templatefile(each.value.source_path, {API_URL = var.api_url})) : each.value.digests.md5

  content_type = each.value.content_type
}


resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "website" {
  bucket = aws_s3_bucket.website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "website" {
  depends_on = [
    aws_s3_bucket_ownership_controls.website,
    aws_s3_bucket_public_access_block.website,
  ]

  bucket = aws_s3_bucket.website.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id

  depends_on = [
    aws_s3_bucket_acl.website
  ]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.website.arn}/*"
      },
    ]
  })
}
