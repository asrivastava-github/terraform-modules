resource "aws_s3_bucket" "repo" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.repo.id
  acl    = var.acl
}