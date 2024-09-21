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

  iam_role_name_prefix = "AmazonBedrockExecutionRoleForAgents_"
  iam_policy_actions   = ["bedrock:InvokeModel"]
  iam_policy_resources = ["arn:${data.aws_partition.current.partition}:bedrock:${data.aws_region.current.name}::foundation-model/${local.bedrockagent_foundation_model}"]

}
