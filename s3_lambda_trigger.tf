resource "aws_s3_bucket_notification" "main_bucket_notification" {
  bucket = module.s3_buckets.main_bucket_name

  lambda_function {
    lambda_function_arn = module.lambda_function.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = ""
    filter_suffix       = ""
  }

  depends_on = [
    module.lambda_function
  ]
}
