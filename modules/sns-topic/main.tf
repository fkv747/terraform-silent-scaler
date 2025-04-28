resource "aws_sns_topic" "silent_scaler_topic" {
  name = var.topic_name

  tags = {
    Project = "SilentScaler"
    Purpose = "Notifications for processed file status"
  }
}
