resource "aws_dynamodb_table" "silent_scaler_table" {
  name           = var.table_name
  billing_mode   = "PAY_PER_REQUEST"  # On-demand billing (no need to manage read/write capacity)
  hash_key       = "file_id"

  attribute {
    name = "file_id"
    type = "S" # Type S means String
  }

  tags = {
    Project = "SilentScaler"
    Purpose = "Track uploaded and processed files"
  }
}
