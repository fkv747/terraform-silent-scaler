output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.silent_scaler_handler.function_name
}

output "lambda_function_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.silent_scaler_handler.arn
}
