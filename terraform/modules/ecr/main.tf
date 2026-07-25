locals {
  repository_names = {
    for service_name in var.service_names :
    service_name => "${var.repository_name_prefix}/${service_name}"
  }

  common_tags = merge(
    {
      Component = "ECR"
      ManagedBy = "Terraform"
    },
    var.tags
  )
}

resource "aws_ecr_repository" "service" {
  for_each = local.repository_names

  name                 = each.value
  image_tag_mutability = var.image_tag_mutability
  force_delete         = var.force_delete

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = merge(
    local.common_tags,
    {
      Service = each.key
    }
  )
}

resource "aws_ecr_lifecycle_policy" "service" {
  for_each = aws_ecr_repository.service

  repository = each.value.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep only the newest untagged image"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 1
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Keep only the newest ${var.max_image_count} images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = var.max_image_count
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
