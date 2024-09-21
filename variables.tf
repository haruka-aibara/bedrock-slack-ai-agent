variable "env" {
  type    = string
  default = "haruka-aibara"
}

variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "slack_channel_id" {
  description = "(Required) ID of the Slack channel. For example, C07EZ1ABC23."
  type        = string
}

variable "slack_team_id" {
  description = "(Required) ID of the Slack workspace authorized with AWS Chatbot. For example, T07EA123LEP."
  type        = string
}
