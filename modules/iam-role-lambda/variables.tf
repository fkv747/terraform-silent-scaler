variable "role_name" {
  description = "The name of the Lambda execution IAM role"
  type        = string
}

variable "sns_topic_arn" {
  description = "ARN of the SNS topic for Lambda permissions"
  type        = string
}

variable "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table for Lambda permissions"
  type        = string
}

variable "main_bucket_arn" {
  description = "The ARN of the main S3 bucket"
  type        = string
}


variable "quarantine_bucket_arn" {
  description = "The ARN of the quarantine S3 bucket"
  type        = string
}

