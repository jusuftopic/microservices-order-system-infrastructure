data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  name_prefix = "${var.project_name}-${var.environment}"

  admin_user_name       = coalesce(var.admin_user_name, "${local.name_prefix}-admin")
  terraform_role_name   = coalesce(var.terraform_role_name, "${local.name_prefix}-terraform-deployer")
  publisher_role_name   = coalesce(var.publisher_role_name, "${local.name_prefix}-container-publisher")
  runtime_role_name     = coalesce(var.runtime_role_name, "${local.name_prefix}-container-runtime")
  instance_profile_name = coalesce(var.instance_profile_name, "${local.name_prefix}-container-runtime")

  github_subject = "repo:${var.github_repository}:ref:refs/heads/${var.github_branch}"

  ecr_repository_arn = join(
    "",
    [
      "arn:aws:ecr:",
      data.aws_region.current.name,
      ":",
      data.aws_caller_identity.current.account_id,
      ":repository/",
      var.ecr_repository_name_prefix,
      "*"
    ]
  )

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Component   = "IAM"
    },
    var.tags
  )
}