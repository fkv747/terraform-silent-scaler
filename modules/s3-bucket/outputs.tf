output "main_bucket_name" {
  description = "The name of the main S3 bucket"
  value       = aws_s3_bucket.main_bucket.id
}

output "quarantine_bucket_name" {
  description = "The name of the quarantine S3 bucket"
  value       = aws_s3_bucket.quarantine_bucket.id
}

output "main_bucket_arn" {
  description = "The ARN of the main S3 bucket"
  value       = aws_s3_bucket.main_bucket.arn
}

output "quarantine_bucket_arn" {
  description = "ARN of the quarantine S3 bucket"
  value       = aws_s3_bucket.quarantine_bucket.arn
}
