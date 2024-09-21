data "aws_iam_policy_document" "agent_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["bedrock.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:${data.aws_partition.current.partition}:bedrock:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:agent/*"]
    }
  }
}

data "aws_iam_policy_document" "agent_permissions" {
  statement {
    actions   = var.iam_policy_actions
    resources = var.iam_policy_resources
  }
}

resource "aws_iam_role" "agent_role" {
  name_prefix        = var.iam_role_name_prefix
  assume_role_policy = data.aws_iam_policy_document.agent_trust.json
  tags               = var.tags
}

resource "aws_iam_role_policy" "agent_policy" {
  role   = aws_iam_role.agent_role.id
  policy = data.aws_iam_policy_document.agent_permissions.json
}
