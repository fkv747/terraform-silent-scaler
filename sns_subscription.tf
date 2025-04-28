resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = module.sns_topic.topic_arn
  protocol  = "email"
  endpoint  = "villanuevakevin08@outlook.com" # <-- change this to your real email
}
