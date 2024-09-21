data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

resource "aws_bedrockagent_agent" "example" {
  agent_name                  = var.agent_name
  foundation_model            = var.bedrock_foundation_model_id
  instruction                 = var.agent_instruction
  agent_resource_role_arn     = aws_iam_role.example.arn
  idle_session_ttl_in_seconds = 500
}
