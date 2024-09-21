variable "env" {
  type    = string
  default = "haruka-aibara"
}

variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "bedrock_foundation_model_id" {
  type        = string
  description = "エージェントの基盤モデルID"
  default     = "anthropic.claude-3-5-sonnet-20240620-v1:0"
}

variable "agent_name" {
  type        = string
  description = "エージェント名"
  default     = "bedrock-slack-ai-agent"
}

variable "agent_instruction" {
  type        = string
  description = "エージェントが実行するタスクについて、明確かつ具体的な指示を提供します。特定のスタイルやトーンを指定することもできます。"
  default     = "質問内容に簡潔かつ的確に答えてください。不要な前置きは避け、ユーザーの意図を理解し、具体的で役立つ情報を提供することに集中してください。必要に応じて、追加の詳細や説明を提案することも可能です。"
}
