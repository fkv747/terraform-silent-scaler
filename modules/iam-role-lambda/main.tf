resource "aws_iam_role" "lambda_execution_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "lambda_extra_permissions" {
  name        = "silent-scaler-lambda-extra-permissions"
  description = "Allow Lambda to access DynamoDB, SNS, and full S3 operations"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "dynamodb:PutItem"
        ],
        Effect   = "Allow",
        Resource = var.dynamodb_table_arn
      },
      {
        Action = [
          "sns:Publish"
        ],
        Effect   = "Allow",
        Resource = var.sns_topic_arn
      },
      {
        Action = "s3:*",
        Effect = "Allow",
        Resource = [
          var.main_bucket_arn,
          "${var.main_bucket_arn}/*",
          var.quarantine_bucket_arn,
          "${var.quarantine_bucket_arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_extra_permissions_attach" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_extra_permissions.arn
}
