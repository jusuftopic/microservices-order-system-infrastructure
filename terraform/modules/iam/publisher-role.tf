data "aws_iam_policy_document" "publisher_role_trust" {
  statement {
    sid     = "AllowGitHubActionsAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"

      identifiers = [
        aws_iam_openid_connect_provider.github_actions.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = [local.github_subject]
    }
  }
}

resource "aws_iam_role" "container_publisher" {
  name               = local.publisher_role_name
  description        = "Role assumed by GitHub Actions to publish application images to Amazon ECR."
  assume_role_policy = data.aws_iam_policy_document.publisher_role_trust.json

  max_session_duration = 3600

  tags = merge(
    local.common_tags,
    {
      IdentityType = "ContainerPublisher"
    }
  )
}