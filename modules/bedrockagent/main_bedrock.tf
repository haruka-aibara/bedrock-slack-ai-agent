data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

resource "aws_bedrockagent_agent" "this" {
  agent_name              = var.agent_name
  agent_resource_role_arn = aws_iam_role.agent_role.arn
  foundation_model        = var.foundation_model

  customer_encryption_key_arn = var.customer_encryption_key_arn
  description                 = var.description
  idle_session_ttl_in_seconds = var.idle_session_ttl_in_seconds
  instruction                 = var.instruction
  prepare_agent               = var.prepare_agent
  skip_resource_in_use_check  = var.skip_resource_in_use_check
  tags                        = var.tags

  dynamic "memory_configuration" {
    for_each = var.memory_configuration != null ? [var.memory_configuration] : []
    content {
      enabled_memory_types = memory_configuration.value["enabled_memory_types"]
      storage_days         = lookup(memory_configuration.value, "storage_days", null)
    }
  }

  dynamic "prompt_override_configuration" {
    for_each = var.prompt_override_configuration != null ? [var.prompt_override_configuration] : []
    content {
      override_lambda = lookup(prompt_override_configuration.value, "override_lambda", null)

      dynamic "prompt_configurations" {
        for_each = lookup(prompt_override_configuration.value, "prompt_configurations", [])
        content {
          base_prompt_template = prompt_configurations.value["base_prompt_template"]
          parser_mode          = prompt_configurations.value["parser_mode"]
          prompt_creation_mode = prompt_configurations.value["prompt_creation_mode"]
          prompt_state         = prompt_configurations.value["prompt_state"]
          prompt_type          = prompt_configurations.value["prompt_type"]

          inference_configuration {
            max_length     = prompt_configurations.value.inference_configuration.max_length
            stop_sequences = prompt_configurations.value.inference_configuration.stop_sequences
            temperature    = prompt_configurations.value.inference_configuration.temperature
            top_k          = prompt_configurations.value.inference_configuration.top_k
            top_p          = prompt_configurations.value.inference_configuration.top_p
          }
        }
      }
    }
  }
}

resource "aws_bedrockagent_agent_alias" "bedrock_agent" {
  agent_alias_name = var.agent_name
  agent_id         = aws_bedrockagent_agent.this.agent_id

  lifecycle {
    replace_triggered_by = [
      aws_bedrockagent_agent.this.agent_version
    ]
  }
}
