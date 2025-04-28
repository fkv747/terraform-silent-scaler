resource "aws_s3_bucket" "main_bucket" {
  bucket = var.main_bucket_name

  tags = {
    Project = "SilentScaler"
    Purpose = "Main Upload Bucket"
  }
}

resource "aws_s3_bucket" "quarantine_bucket" {
  bucket = var.quarantine_bucket_name

  tags = {
    Project = "SilentScaler"
    Purpose = "Quarantine Bucket"
  }
}
