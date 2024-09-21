data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

resource "aws_bedrockagent_agent" "example" {
  agent_name                  = "my-agent-name"
  agent_resource_role_arn     = aws_iam_role.example.arn
  idle_session_ttl_in_seconds = 500
  foundation_model            = "anthropic.claude-v2"
  instruction                 = "質問内容に簡潔かつ的確に答えてください。不要な前置きは避け、ユーザーの意図を理解し、具体的で役立つ情報を提供することに集中してください。必要に応じて、追加の詳細や説明を提案することも可能です。"
}
