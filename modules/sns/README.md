# AWS SNS Topic Terraform Module

This Terraform module creates an AWS SNS Topic (`aws_sns_topic`) with all available arguments. It allows you to manage all configurations related to the SNS topic within the module.

## Table of Contents

- [AWS SNS Topic Terraform Module](#aws-sns-topic-terraform-module)
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
module "sns_topic" {
  source = "./path_to_module"

  name = "user-updates-topic"

  tags = {
    Environment = "Production"
  }

  # Optional configurations
  delivery_policy = jsonencode({
    http = {
      defaultHealthyRetryPolicy = {
        minDelayTarget       = 20
        maxDelayTarget       = 20
        numRetries           = 3
        numMaxDelayRetries   = 0
        numNoDelayRetries    = 0
        numMinDelayRetries   = 0
        backoffFunction      = "linear"
      }
      disableSubscriptionOverrides = false
      defaultThrottlePolicy = {
        maxReceivesPerSecond = 1
      }
    }
  })

  # For server-side encryption (SSE)
  kms_master_key_id = "alias/aws/sns"

  # For FIFO topics
  fifo_topic                  = true
  content_based_deduplication = true
}
```

**Note:** Replace `"./path_to_module"` with the actual path to the module directory.

## Inputs

| Name                                       | Description                                                                                                                                                                                                                                                                                                                                                                     | Type           | Default | Required |
|--------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------|---------|:--------:|
| name                                       | (Optional) The name of the topic. Topic names must be made up of only uppercase and lowercase ASCII letters, numbers, underscores, and hyphens, and must be between 1 and 256 characters long. For a FIFO (first-in-first-out) topic, the name must end with the .fifo suffix. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix. | `string`       | `null`  |    no    |
| name_prefix                                | (Optional) Creates a unique name beginning with the specified prefix. Conflicts with name.                                                                                                                                                                                                                                                                                       | `string`       | `null`  |    no    |
| display_name                               | (Optional) The display name for the topic.                                                                                                                                                                                                                                                                                                                                      | `string`       | `null`  |    no    |
| policy                                     | (Optional) The fully-formed AWS policy as JSON.                                                                                                                                                                                                                                                                                                                                 | `string`       | `null`  |    no    |
| delivery_policy                            | (Optional) The SNS delivery policy.                                                                                                                                                                                                                                                                                                                                             | `string`       | `null`  |    no    |
| application_success_feedback_role_arn      | (Optional) The IAM role permitted to receive success feedback for this topic.                                                                                                                                                                                                                                                                                                    | `string`       | `null`  |    no    |
| application_success_feedback_sample_rate   | (Optional) Percentage of success to sample.                                                                                                                                                                                                                                                                                                                                     | `number`       | `null`  |    no    |
| application_failure_feedback_role_arn      | (Optional) IAM role for failure feedback.                                                                                                                                                                                                                                                                                                                                       | `string`       | `null`  |    no    |
| http_success_feedback_role_arn             | (Optional) The IAM role permitted to receive success feedback for this topic.                                                                                                                                                                                                                                                                                                    | `string`       | `null`  |    no    |
| http_success_feedback_sample_rate          | (Optional) Percentage of success to sample.                                                                                                                                                                                                                                                                                                                                     | `number`       | `null`  |    no    |
| http_failure_feedback_role_arn             | (Optional) IAM role for failure feedback.                                                                                                                                                                                                                                                                                                                                       | `string`       | `null`  |    no    |
| kms_master_key_id                          | (Optional) The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK.                                                                                                                                                                                                                                                                                    | `string`       | `null`  |    no    |
| signature_version                          | (Optional) If SignatureVersion should be 1 (SHA1) or 2 (SHA256).                                                                                                                                                                                                                                                                                                                | `string`       | `null`  |    no    |
| tracing_config                             | (Optional) Tracing mode of an Amazon SNS topic. Valid values: "PassThrough", "Active".                                                                                                                                                                                                                                                                                           | `string`       | `null`  |    no    |
| fifo_topic                                 | (Optional) Boolean indicating whether or not to create a FIFO (first-in-first-out) topic.                                                                                                                                                                                                                                                                                        | `bool`         | `false` |    no    |
| archive_policy                             | (Optional) The message archive policy for FIFO topics.                                                                                                                                                                                                                                                                                                                          | `string`       | `null`  |    no    |
| content_based_deduplication                | (Optional) Enables content-based deduplication for FIFO topics.                                                                                                                                                                                                                                                                                                                 | `bool`         | `null`  |    no    |
| lambda_success_feedback_role_arn           | (Optional) The IAM role permitted to receive success feedback for this topic.                                                                                                                                                                                                                                                                                                    | `string`       | `null`  |    no    |
| lambda_success_feedback_sample_rate        | (Optional) Percentage of success to sample.                                                                                                                                                                                                                                                                                                                                     | `number`       | `null`  |    no    |
| lambda_failure_feedback_role_arn           | (Optional) IAM role for failure feedback.                                                                                                                                                                                                                                                                                                                                       | `string`       | `null`  |    no    |
| sqs_success_feedback_role_arn              | (Optional) The IAM role permitted to receive success feedback for this topic.                                                                                                                                                                                                                                                                                                    | `string`       | `null`  |    no    |
| sqs_success_feedback_sample_rate           | (Optional) Percentage of success to sample.                                                                                                                                                                                                                                                                                                                                     | `number`       | `null`  |    no    |
| sqs_failure_feedback_role_arn              | (Optional) IAM role for failure feedback.                                                                                                                                                                                                                                                                                                                                       | `string`       | `null`  |    no    |
| firehose_success_feedback_role_arn         | (Optional) The IAM role permitted to receive success feedback for this topic.                                                                                                                                                                                                                                                                                                    | `string`       | `null`  |    no    |
| firehose_success_feedback_sample_rate      | (Optional) Percentage of success to sample.                                                                                                                                                                                                                                                                                                                                     | `number`       | `null`  |    no    |
| firehose_failure_feedback_role_arn         | (Optional) IAM role for failure feedback.                                                                                                                                                                                                                                                                                                                                       | `string`       | `null`  |    no    |
| tags                                       | (Optional) Key-value map of resource tags.                                                                                                                                                                                                                                                                                                                                      | `map(string)`  | `{}`    |    no    |

## Outputs

| Name                   | Description                                                                                                         |
|------------------------|---------------------------------------------------------------------------------------------------------------------|
| arn                    | The ARN of the SNS topic.                                                                                           |
| id                     | The ARN of the SNS topic (same as arn).                                                                             |
| beginning_archive_time | The oldest timestamp at which a FIFO topic subscriber can start a replay.                                           |
| owner                  | The AWS Account ID of the SNS topic owner.                                                                          |
| tags_all               | A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.|

## Notes

- **FIFO Topics:** To create a FIFO topic, set `fifo_topic` to `true` and ensure the topic name ends with `.fifo`.
- **Server-side Encryption (SSE):** To enable SSE, provide a `kms_master_key_id`. You can use the default AWS managed CMK by setting `kms_master_key_id = "alias/aws/sns"`.
- **Delivery Policy:** The `delivery_policy` should be a JSON-formatted string. Use `jsonencode()` to format a JSON object in HCL.
- **Message Delivery Status Arguments:** The various `<endpoint>_success_feedback_role_arn` and `<endpoint>_failure_feedback_role_arn` arguments allow Amazon SNS to write to CloudWatch Logs on your behalf. Configure these as needed.
- **Tags:** The tags provided will be applied to the SNS topic.
- **Permissions:** Ensure that the AWS user or role applying this Terraform configuration has the necessary permissions to create SNS topics and associated resources.

## Author

- haruka-aibara

## License

- MPL-2.0 license
