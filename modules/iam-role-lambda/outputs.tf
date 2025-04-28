output "role_arn" {
  description = "The ARN of the Lambda Execution Role"
  value       = aws_iam_role.lambda_execution_role.arn
}
