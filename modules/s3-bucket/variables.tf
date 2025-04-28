variable "main_bucket_name" {
  description = "Name of the main S3 bucket for valid uploads"
  type        = string
}

variable "quarantine_bucket_name" {
  description = "Name of the quarantine S3 bucket for invalid uploads"
  type        = string
}
