variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "lambda_handler" {
  description = "The function entrypoint in the code"
  type        = string
}

variable "lambda_runtime" {
  description = "The runtime environment for the Lambda function"
  type        = string
}

variable "lambda_role_arn" {
  description = "The ARN of the IAM role assumed by Lambda"
  type        = string
}

variable "lambda_package" {
  description = "The path to the deployment package (ZIP file)"
  type        = string
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "sns_topic_arn" {
  description = "The ARN of the SNS topic"
  type        = string
}

variable "main_bucket_name" {
  description = "The name of the main S3 bucket"
  type        = string
}

variable "quarantine_bucket_name" {
  description = "The name of the quarantine S3 bucket"
  type        = string
}
