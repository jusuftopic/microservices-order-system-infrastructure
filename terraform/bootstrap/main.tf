module "iam" {
  source = "../modules/iam"

  project_name = var.project_name
  environment  = var.environment

  github_repository = var.github_repository
  github_branch     = var.github_branch

  tags = var.tags
}