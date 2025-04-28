# S3 Module
module "s3_buckets" {
  source = "./modules/s3-bucket"

  main_bucket_name = "silent-scaler-main-bucket-fkv"
  quarantine_bucket_name = "silent-scaler-quarantine-bucket-fkv"
}

# DynamoDB Module
module "dynamodb_table" {
  source = "./modules/dynamodb-table"

  table_name = "SilentScalerTable"
}

# Lambda functions Module
module "lambda_function" {
  source = "./modules/lambda-function"

  lambda_function_name = "silent-scaler-handler"
  lambda_handler       = "lambda_function.handler"
  lambda_runtime       = "python3.12"
  lambda_role_arn      = module.iam_lambda_role.role_arn
  lambda_package       = "${path.root}/lambda_src/function.zip"

  dynamodb_table_name  = module.dynamodb_table.dynamodb_table_name
  sns_topic_arn        = module.sns_topic.topic_arn
  main_bucket_name       = module.s3_buckets.main_bucket_name
  quarantine_bucket_name = module.s3_buckets.quarantine_bucket_name

}


# IAM Role module
module "iam_lambda_role" {
  source = "./modules/iam-role-lambda"
  role_name = "silent-scaler-lambda-role"

  sns_topic_arn        = module.sns_topic.topic_arn
  dynamodb_table_arn   = module.dynamodb_table.dynamodb_table_arn
  main_bucket_arn      = module.s3_buckets.main_bucket_arn
  quarantine_bucket_arn = module.s3_buckets.quarantine_bucket_arn
}

# SNS Module
module "sns_topic" {
  source     = "./modules/sns-topic"
  topic_name = "SilentScalerTopic"
}


