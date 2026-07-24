data "aws_iam_policy_document" "container_publisher" {
  statement {
    sid       = "AllowECRAuthentication"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowPublishImagesToProjectRepositories"
    effect = "Allow"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]

    resources = [local.ecr_repository_arn]
  }
}

resource "aws_iam_policy" "container_publisher" {
  name        = "${local.name_prefix}-container-publisher"
  description = "Allows GitHub Actions to authenticate with ECR and publish images to project repositories."
  policy      = data.aws_iam_policy_document.container_publisher.json

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "container_publisher" {
  role       = aws_iam_role.container_publisher.name
  policy_arn = aws_iam_policy.container_publisher.arn
}

data "aws_iam_policy_document" "container_runtime" {
  statement {
    sid       = "AllowECRAuthentication"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowPullImagesFromProjectRepositories"
    effect = "Allow"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer"
    ]

    resources = [local.ecr_repository_arn]
  }
}

resource "aws_iam_policy" "container_runtime" {
  name        = "${local.name_prefix}-container-runtime"
  description = "Allows EC2 runtime instances to authenticate with ECR and pull images from project repositories."
  policy      = data.aws_iam_policy_document.container_runtime.json

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "container_runtime" {
  role       = aws_iam_role.container_runtime.name
  policy_arn = aws_iam_policy.container_runtime.arn
}