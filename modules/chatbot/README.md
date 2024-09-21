# AWS Chatbot Slack Channel Configuration Terraform Module

This Terraform module creates an AWS Chatbot Slack Channel Configuration (`aws_chatbot_slack_channel_configuration`) along with the necessary IAM role and policies. It allows you to manage all configurations related to the Slack channel within the module.

## Table of Contents

- [AWS Chatbot Slack Channel Configuration Terraform Module](#aws-chatbot-slack-channel-configuration-terraform-module)
  - [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Usage](#usage)
  - [Inputs](#inputs)
  - [Outputs](#outputs)
  - [Notes](#notes)
  - [Author](#author)
  - [License](#license)

## Requirements

- Terraform >= 1.9.6
- AWS Provider >= 5.68.0

## Usage

```hcl
module "chatbot_slack_channel" {
  source = "./path_to_module"

  configuration_name = "my-slack-channel-config"
  slack_channel_id   = "C07EZ1ABC23"
  slack_team_id      = "T07EA123LEP"
  sns_topic_arns     = ["arn:aws:sns:us-west-2:123456789012:my-topic"]
  tags = {
    Environment = "Production"
  }

  # Optional IAM policies to attach to the role
  additional_iam_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSNSReadOnlyAccess"
  ]
}
```

**Note:** Replace `"./path_to_module"` with the actual path to the module directory.

## Inputs

| Name                         | Description                                                                                                                                                                                      | Type          | Default                               | Required |
|------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|---------------------------------------|:--------:|
| configuration_name           | (Required) Name of the Slack channel configuration.                                                                                                                                              | `string`      | n/a                                   |   yes    |
| slack_channel_id             | (Required) ID of the Slack channel. For example, C07EZ1ABC23.                                                                                                                                    | `string`      | n/a                                   |   yes    |
| slack_team_id                | (Required) ID of the Slack workspace authorized with AWS Chatbot. For example, T07EA123LEP.                                                                                                      | `string`      | n/a                                   |   yes    |
| guardrail_policy_arns        | (Optional) List of IAM policy ARNs that are applied as channel guardrails. The AWS managed AdministratorAccess policy is applied by default if this is not set.                                   | `list(string)`| `null`                                |    no    |
| logging_level                | (Optional) Logging levels include ERROR, INFO, or NONE.                                                                                                                                          | `string`      | `null`                                |    no    |
| sns_topic_arns               | (Optional) ARNs of the SNS topics that deliver notifications to AWS Chatbot.                                                                                                                      | `list(string)`| `null`                                |    no    |
| user_authorization_required  | (Optional) Enables use of a user role requirement in your chat configuration.                                                                                                                    | `bool`        | `null`                                |    no    |
| tags                         | (Optional) Map of tags assigned to the resource.                                                                                                                                                  | `map(string)` | `{}`                                  |    no    |
| iam_role_name_prefix         | (Optional) Prefix for the IAM role name.                                                                                                                                                         | `string`      | `"ChatbotRole_"`                      |    no    |
| additional_iam_policy_arns   | (Optional) List of additional IAM policy ARNs to attach to the IAM role.                                                                                                                         | `list(string)`| `[]`                                  |    no    |

## Outputs

| Name                   | Description                                                                                                         |
|------------------------|---------------------------------------------------------------------------------------------------------------------|
| chat_configuration_arn | ARN of the Slack channel configuration.                                                                             |
| slack_channel_name     | Name of the Slack channel.                                                                                          |
| slack_team_name        | Name of the Slack team.                                                                                             |
| iam_role_arn           | ARN of the IAM role assumed by AWS Chatbot.                                                                         |
| tags_all               | Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block. |

## Notes

- **IAM Role Creation:** The module creates an IAM role (`aws_iam_role`) and attaches the necessary policies for AWS Chatbot to function. The role is automatically assumed by AWS Chatbot.
- **IAM Policy Customization:**
  - By default, the AWS managed `AdministratorAccess` policy is attached to the role. If you want to specify custom guardrail policies, provide them using the `guardrail_policy_arns` variable.
  - You can attach additional IAM policies to the role using the `additional_iam_policy_arns` variable.
- **Tags:** The tags provided will be applied to both the Chatbot Slack channel configuration and the IAM role.
- **Permissions:** Ensure that the AWS user or role applying this Terraform configuration has the necessary permissions to create IAM roles and policies, as well as Chatbot configurations.
- **Slack Integration:** Before using this module, make sure that your Slack workspace is authorized with AWS Chatbot. You can find the `slack_team_id` and `slack_channel_id` from your Slack workspace.

## Author

- haruka-aibara

## License

- MPL-2.0 license
