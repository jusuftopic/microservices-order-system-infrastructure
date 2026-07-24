data "aws_iam_policy_document" "runtime_role_trust" {
  statement {
    sid     = "AllowEC2AssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "container_runtime" {
  name               = local.runtime_role_name
  description        = "Role used by EC2 instances to pull application images from Amazon ECR."
  assume_role_policy = data.aws_iam_policy_document.runtime_role_trust.json

  tags = merge(
    local.common_tags,
    {
      IdentityType = "ContainerRuntime"
    }
  )
}

resource "aws_iam_instance_profile" "container_runtime" {
  name = local.instance_profile_name
  role = aws_iam_role.container_runtime.name

  tags = merge(
    local.common_tags,
    {
      IdentityType = "ContainerRuntimeInstanceProfile"
    }
  )
}