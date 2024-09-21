# AWS Bedrock Agent Terraform Module

This Terraform module creates an AWS Bedrock Agent (`aws_bedrockagent_agent`) along with the necessary IAM role and policies. It allows you to manage all configurations related to the Bedrock Agent within the module.

## Table of Contents

- [Requirements](#requirements)
- [Providers](#providers)
- [Usage](#usage)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [Notes](#notes)

## Requirements

- Terraform >= 1.9.6
- AWS Provider >= 5.68.0

## Usage

```hcl
module "bedrock_agent" {
  source = "./path_to_module"

  agent_name                  = "my-agent-name"
  foundation_model            = "anthropic.claude-v2"
  idle_session_ttl_in_seconds = 500
  tags = {
    Environment = "Production"
  }

  # Optional IAM policy resources (specify the resources the agent can access)
  iam_policy_resources = [
    "arn:${data.aws_partition.current.partition}:bedrock:${data.aws_region.current.name}::foundation-model/anthropic.claude-v2",
  ]

  # Optional prompt override configuration
  prompt_override_configuration = {
    override_lambda       = "arn:aws:lambda:region:account-id:function:lambda-name"
    prompt_configurations = [
      {
        base_prompt_template = "Your base prompt template here"
        parser_mode          = "DEFAULT"
        prompt_creation_mode = "OVERRIDDEN"
        prompt_state         = "ENABLED"
        prompt_type          = "ORCHESTRATION"
        inference_configuration = {
          max_length     = 100
          stop_sequences = ["\n"]
          temperature    = 0.7
          top_k          = 50
          top_p          = 0.9
        }
      }
    ]
  }
}
```

**Note:** Replace `"./path_to_module"` with the actual path to the module directory.

## Inputs

| Name                         | Description                                                                                                                                                                                                                                                                                                                                          | Type          | Default                                                                                                                           | Required |
|------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|-----------------------------------------------------------------------------------------------------------------------------------|:--------:|
| agent_name                   | (Required) Name of the agent.                                                                                                                                                                                                                                                                                                                       | `string`      | n/a                                                                                                                               |   yes    |
| foundation_model             | (Required) Foundation model used for orchestration by the agent.                                                                                                                                                                                                                                                                                     | `string`      | n/a                                                                                                                               |   yes    |
| idle_session_ttl_in_seconds  | (Optional) Number of seconds for which Amazon Bedrock keeps information about a user's conversation with the agent. A user interaction remains active for the amount of time specified. If no conversation occurs during this time, the session expires and Amazon Bedrock deletes any data provided before the timeout.                               | `number`      | `null`                                                                                                                            |    no    |
| customer_encryption_key_arn  | (Optional) ARN of the AWS KMS key that encrypts the agent.                                                                                                                                                                                                                                                                                          | `string`      | `null`                                                                                                                            |    no    |
| description                  | (Optional) Description of the agent.                                                                                                                                                                                                                                                                                                                 | `string`      | `null`                                                                                                                            |    no    |
| instruction                  | (Optional) Instructions that tell the agent what it should do and how it should interact with users.                                                                                                                                                                                                                                                 | `string`      | `null`                                                                                                                            |    no    |
| prepare_agent                | (Optional) Whether to prepare the agent after creation or modification. Defaults to true.                                                                                                                                                                                                                                                            | `bool`        | `true`                                                                                                                            |    no    |
| prompt_override_configuration| (Optional) Configurations to override prompt templates in different parts of an agent sequence. For more information, see Advanced prompts. See [Prompt Override Configuration](#prompt-override-configuration) for details.                                                                                                                         | `any`         | `null`                                                                                                                            |    no    |
| skip_resource_in_use_check   | (Optional) Whether the in-use check is skipped when deleting the agent.                                                                                                                                                                                                                                                                              | `bool`        | `null`                                                                                                                            |    no    |
| tags                         | (Optional) Map of tags assigned to the resource.                                                                                                                                                                                                                                                                                                     | `map(string)` | `{}`                                                                                                                              |    no    |
| iam_role_name_prefix         | (Optional) Prefix for the IAM role name.                                                                                                                                                                                                                                                                                                             | `string`      | `"AmazonBedrockExecutionRoleForAgents_"`                                                                                          |    no    |
| iam_policy_actions           | (Optional) List of actions for the IAM policy attached to the role.                                                                                                                                                                                                                                                                                  | `list(string)`| `["bedrock:InvokeModel"]`                                                                                                         |    no    |
| iam_policy_resources         | (Optional) List of resources for the IAM policy attached to the role.                                                                                                                                                                                                                                                                                | `list(string)`| `[]`                                                                                                                              |    no    |

### Prompt Override Configuration

The `prompt_override_configuration` variable allows you to override prompt templates in different parts of an agent sequence. It should be provided as a map with the following structure:

```hcl
prompt_override_configuration = {
  override_lambda       = "ARN of your Lambda function"
  prompt_configurations = [
    {
      base_prompt_template = "Your base prompt template here"
      parser_mode          = "DEFAULT" # Valid values: DEFAULT, OVERRIDDEN
      prompt_creation_mode = "OVERRIDDEN" # Valid values: DEFAULT, OVERRIDDEN
      prompt_state         = "ENABLED" # Valid values: ENABLED, DISABLED
      prompt_type          = "ORCHESTRATION" # Valid values: PRE_PROCESSING, ORCHESTRATION, POST_PROCESSING, KNOWLEDGE_BASE_RESPONSE_GENERATION
      inference_configuration = {
        max_length     = 100
        stop_sequences = ["\n"]
        temperature    = 0.7
        top_k          = 50
        top_p          = 0.9
      }
    },
    # Add more prompt_configurations if needed
  ]
}
```

## Outputs

| Name         | Description                                                                                                                |
|--------------|----------------------------------------------------------------------------------------------------------------------------|
| agent_arn    | ARN of the agent.                                                                                                          |
| agent_id     | Unique identifier of the agent.                                                                                            |
| agent_version| Version of the agent.                                                                                                      |
| id           | Unique identifier of the agent.                                                                                            |
| role_arn     | ARN of the IAM role used by the agent.                                                                                     |
| tags_all     | Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.        |

## Notes

- **IAM Role Creation:** The module creates an IAM role (`aws_iam_role`) and attaches the necessary policies for the Bedrock agent to function. The role is automatically assumed by the Bedrock agent.
- **IAM Policy Customization:**
  - `iam_policy_actions`: Defaults to `["bedrock:InvokeModel"]`. Modify this list to include additional actions if necessary.
  - `iam_policy_resources`: Specify the resources that the agent is allowed to access. This should include the ARNs of the foundation models or other resources the agent needs.
- **Tags:** The tags provided will be applied to both the Bedrock agent and the IAM role.
- **Permissions:** Ensure that the AWS user or role applying this Terraform configuration has the necessary permissions to create IAM roles and policies, as well as Bedrock agents.
- **Data Sources:** The module uses data sources (`aws_caller_identity`, `aws_partition`, and `aws_region`) to dynamically build ARNs and other AWS-specific values.
- **Prompt Override Configuration:** The `prompt_override_configuration` is optional and allows advanced customization of the agent's behavior. Refer to the [Prompt Override Configuration](#prompt-override-configuration) section for details.

## Advanced Usage

If you need to customize the IAM role further or add more complex policies, you can adjust the `aws_iam_policy_document` resources within the module.

### Example with Custom IAM Policy Actions

```hcl
module "bedrock_agent" {
  source = "./path_to_module"

  agent_name                  = "my-agent-name"
  foundation_model            = "anthropic.claude-v2"
  idle_session_ttl_in_seconds = 500
  tags = {
    Environment = "Production"
  }

  iam_policy_actions = [
    "bedrock:InvokeModel",
    "bedrock:ListModels"
  ]

  iam_policy_resources = [
    "arn:${data.aws_partition.current.partition}:bedrock:${data.aws_region.current.name}::foundation-model/anthropic.claude-v2",
  ]
}
```

## Author

- haruka-aibara

## License

- MPL-2.0 license
