variable "agent_name" {
  description = "(Required) Name of the agent."
  type        = string
}

variable "foundation_model" {
  description = "(Required) Foundation model used for orchestration by the agent."
  type        = string
}

variable "idle_session_ttl_in_seconds" {
  description = "(Optional) Number of seconds for which Amazon Bedrock keeps information about a user's conversation with the agent. A user interaction remains active for the amount of time specified. If no conversation occurs during this time, the session expires and Amazon Bedrock deletes any data provided before the timeout."
  type        = number
  default     = null
}

variable "customer_encryption_key_arn" {
  description = "(Optional) ARN of the AWS KMS key that encrypts the agent."
  type        = string
  default     = null
}

variable "description" {
  description = "(Optional) Description of the agent."
  type        = string
  default     = null
}

variable "instruction" {
  description = "(Optional) Instructions that tell the agent what it should do and how it should interact with users."
  type        = string
  default     = null
}

variable "prepare_agent" {
  description = "(Optional) Whether to prepare the agent after creation or modification. Defaults to true."
  type        = bool
  default     = true
}

variable "prompt_override_configuration" {
  description = "(Optional) Configurations to override prompt templates in different parts of an agent sequence. For more information, see Advanced prompts."
  type        = any
  default     = null
}

variable "skip_resource_in_use_check" {
  description = "(Optional) Whether the in-use check is skipped when deleting the agent."
  type        = bool
  default     = null
}

variable "tags" {
  description = "(Optional) Map of tags assigned to the resource."
  type        = map(string)
  default     = {}
}

variable "iam_role_name_prefix" {
  description = "(Optional) Prefix for the IAM role name."
  type        = string
  default     = "AmazonBedrockExecutionRoleForAgents_"
}

variable "iam_policy_actions" {
  description = "(Optional) List of actions for the IAM policy attached to the role."
  type        = list(string)
  default     = ["bedrock:InvokeModel"]
}

variable "iam_policy_resources" {
  description = "(Optional) List of resources for the IAM policy attached to the role."
  type        = list(string)
  default     = []
}
