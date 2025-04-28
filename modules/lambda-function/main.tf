resource "aws_lambda_function" "silent_scaler_handler" {
  function_name = var.lambda_function_name
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  role          = var.lambda_role_arn
  filename      = var.lambda_package
  source_code_hash = filebase64sha256(var.lambda_package) # calculates the checksum of the .zip file contents.

  environment {
    variables = {
      TABLE_NAME = var.dynamodb_table_name
      TOPIC_ARN  = var.sns_topic_arn
      MAIN_BUCKET        = var.main_bucket_name
      QUARANTINE_BUCKET  = var.quarantine_bucket_name
    }
  }

  tags = {
    Project = "SilentScaler"
    Purpose = "Handle file uploads from S3 and process into DynamoDB and SNS"
  }
}
