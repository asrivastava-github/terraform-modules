resource "aws_s3_bucket" "repo" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.repo.id
  acl    = var.acl
}