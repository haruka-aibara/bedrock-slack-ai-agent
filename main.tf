data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

module "bedrock_agent" {
  source = "./modules/bedrockagent"

  agent_name       = local.bedrockagent_agent_name
  foundation_model = local.bedrockagent_foundation_model

  description                 = local.bedrockagent_description
  idle_session_ttl_in_seconds = local.bedrockagent_idle_session_ttl_in_seconds
  instruction                 = local.bedrockagent_instruction
  prepare_agent               = local.bedrockagent_prepare_agent
  iam_role_name_prefix        = local.bedrockagent_iam_role_name_prefix
  iam_policy_actions          = ["bedrock:InvokeModel"]
  iam_policy_resources        = ["arn:${data.aws_partition.current.partition}:bedrock:${data.aws_region.current.name}::foundation-model/${local.bedrockagent_foundation_model}"]
}

module "chatbot_slack_channel_configuration" {
  source = "./modules/chatbot"

  configuration_name = local.app_name
  slack_team_id      = var.slack_team_id
  slack_channel_id   = var.slack_channel_id

  iam_policy_arns = [
    aws_iam_policy.bedrock_invoke_agent_policy.arn
  ]
  guardrail_policy_arns = [
    aws_iam_policy.bedrock_invoke_agent_policy.arn
  ]
}

data "aws_iam_policy_document" "bedrock_invoke_agent_policy" {
  statement {
    effect = "Allow"
    actions = [
      "bedrock:InvokeAgent"
    ]
    resources = [
      "arn:aws:bedrock:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:agent-alias/${module.bedrock_agent.agent_id}/${module.bedrock_agent.agent_alias_id}"
    ]
  }
}

resource "aws_iam_policy" "bedrock_invoke_agent_policy" {
  name        = "${local.app_name}-bedrock-invoke-agent-policy"
  description = "Allows bedrock:InvokeAgent on specific agent alias"
  policy      = data.aws_iam_policy_document.bedrock_invoke_agent_policy.json
}
