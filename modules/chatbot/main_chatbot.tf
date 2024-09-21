resource "aws_chatbot_slack_channel_configuration" "this" {
  configuration_name          = var.configuration_name
  iam_role_arn                = aws_iam_role.chatbot_role.arn
  slack_channel_id            = var.slack_channel_id
  slack_team_id               = var.slack_team_id
  guardrail_policy_arns       = var.guardrail_policy_arns
  logging_level               = var.logging_level
  sns_topic_arns              = var.sns_topic_arns
  user_authorization_required = var.user_authorization_required
  tags                        = var.tags
}
