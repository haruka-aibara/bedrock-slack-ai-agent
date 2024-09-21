variable "configuration_name" {
  description = "(Required) Name of the Slack channel configuration."
  type        = string
}

variable "slack_channel_id" {
  description = "(Required) ID of the Slack channel. For example, C07EZ1ABC23."
  type        = string
}

variable "slack_team_id" {
  description = "(Required) ID of the Slack workspace authorized with AWS Chatbot. For example, T07EA123LEP."
  type        = string
}

variable "guardrail_policy_arns" {
  description = "(Optional) List of IAM policy ARNs that are applied as channel guardrails. The AWS managed AdministratorAccess policy is applied by default if this is not set."
  type        = list(string)
  default     = null
}

variable "logging_level" {
  description = "(Optional) Logging levels include ERROR, INFO, or NONE."
  type        = string
  default     = null
}

variable "sns_topic_arns" {
  description = "(Optional) ARNs of the SNS topics that deliver notifications to AWS Chatbot."
  type        = list(string)
  default     = null
}

variable "user_authorization_required" {
  description = "(Optional) Enables use of a user role requirement in your chat configuration."
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
  default     = "ChatbotRole_"
}

variable "additional_iam_policy_arns" {
  description = "(Optional) List of additional IAM policy ARNs to attach to the IAM role."
  type        = list(string)
  default     = []
}
