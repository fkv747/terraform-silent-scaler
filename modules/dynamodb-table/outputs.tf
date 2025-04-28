output "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  value       = aws_dynamodb_table.silent_scaler_table.name
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.silent_scaler_table.arn
}

