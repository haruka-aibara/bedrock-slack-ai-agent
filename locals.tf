locals {
  app_name = "bedrock-slack-ai-agent"

  # bedrockagent module required arguments
  bedrockagent_agent_name       = local.app_name
  bedrockagent_foundation_model = "anthropic.claude-3-haiku-20240307-v1:0"

  # bedrockagent module optional arguments 
  bedrockagent_description                 = "Slack を介して対話できる AI エージェント"
  bedrockagent_idle_session_ttl_in_seconds = 500
  bedrockagent_instruction                 = "質問内容に簡潔かつ的確に答えてください。不要な前置きは避け、ユーザーの意図を理解し、具体的で役立つ情報を提供することに集中してください。必要に応じて、追加の詳細や説明を提案することも可能です。"
  bedrockagent_prepare_agent               = true
  bedrockagent_iam_role_name_prefix        = "AmazonBedrockExecutionRoleForAgents_"
}
