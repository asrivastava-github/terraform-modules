output "id" {
  description = "The S3 ID"
  value       = aws_s3_bucket.repo.id
}

output "arn" {
  description = "The S3 ARN"
  value       = aws_s3_bucket.repo.arn
}
