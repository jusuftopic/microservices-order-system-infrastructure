data "aws_iam_policy_document" "terraform_role_trust" {
  statement {
    sid     = "AllowAdministratorAssumeRoleWithMFA"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"

      identifiers = [
        aws_iam_user.admin.arn
      ]
    }

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

resource "aws_iam_role" "terraform_deployer" {
  name               = local.terraform_role_name
  description        = "Role assumed by the administrator to deploy infrastructure with Terraform."
  assume_role_policy = data.aws_iam_policy_document.terraform_role_trust.json

  max_session_duration = 3600

  tags = merge(
    local.common_tags,
    {
      IdentityType = "InfrastructureDeployer"
    }
  )
}

resource "aws_iam_role_policy_attachment" "terraform_deployer" {
  for_each = var.terraform_role_policy_arns

  role       = aws_iam_role.terraform_deployer.name
  policy_arn = each.value
}