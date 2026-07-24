resource "aws_iam_user" "admin" {
  name = local.admin_user_name
  force_destroy = false

  tags = merge(
    local.common_tags,
    {
      IdentityType = "HumanAdministrator"
    }
  )
}

data "aws_iam_policy_document" "admin_assume_terraform_role" {
  statement {
    sid     = "AllowAssumeTerraformRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    resources = [
      aws_iam_role.terraform_deployer.arn
    ]
  }
}

resource "aws_iam_policy" "admin_assume_terraform_role" {
  name        = "${local.name_prefix}-admin-assume-terraform-role"
  description = "Allows the administrator IAM user to assume the Terraform deployment role."
  policy      = data.aws_iam_policy_document.admin_assume_terraform_role.json

  tags = local.common_tags
}

resource "aws_iam_user_policy_attachment" "admin_assume_terraform_role" {
  user       = aws_iam_user.admin.name
  policy_arn = aws_iam_policy.admin_assume_terraform_role.arn
}