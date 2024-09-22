data "aws_iam_policy_document" "chatbot_assume_role_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["chatbot.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "chatbot_role" {
  name_prefix        = var.iam_role_name_prefix
  assume_role_policy = data.aws_iam_policy_document.chatbot_assume_role_policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "policy_attachments" {
  count      = length(var.iam_policy_arns)
  role       = aws_iam_role.chatbot_role.name
  policy_arn = var.iam_policy_arns[count.index]
}
