variable "project_name" {
  description = "Name of the project used for IAM resource naming and tagging."
  type        = string
  default     = "microservices-order-system"

  validation {
    condition     = length(trimspace(var.project_name)) > 0
    error_message = "project_name must not be empty."
  }
}

variable "environment" {
  description = "Deployment environment represented by this IAM configuration."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, test, staging, prod."
  }
}

variable "admin_user_name" {
  description = "Optional explicit name for the administrator IAM user."
  type        = string
  default     = null
}

variable "terraform_role_name" {
  description = "Optional explicit name for the Terraform deployment role."
  type        = string
  default     = null
}

variable "publisher_role_name" {
  description = "Optional explicit name for the GitHub Actions container publisher role."
  type        = string
  default     = null
}

variable "runtime_role_name" {
  description = "Optional explicit name for the EC2 container runtime role."
  type        = string
  default     = null
}

variable "instance_profile_name" {
  description = "Optional explicit name for the EC2 instance profile."
  type        = string
  default     = null
}

variable "github_repository" {
  description = "GitHub repository allowed to assume the container publisher role, in owner/repository format."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$", var.github_repository))
    error_message = "github_repository must use the owner/repository format."
  }
}

variable "github_branch" {
  description = "GitHub branch allowed to assume the container publisher role."
  type        = string
  default     = "main"

  validation {
    condition     = length(trimspace(var.github_branch)) > 0
    error_message = "github_branch must not be empty."
  }
}

variable "ecr_repository_name_prefix" {
  description = "Prefix used to restrict publisher and runtime permissions to project ECR repositories."
  type        = string
  default     = "microservices-order-system"

  validation {
    condition     = length(trimspace(var.ecr_repository_name_prefix)) > 0
    error_message = "ecr_repository_name_prefix must not be empty."
  }
}

variable "terraform_role_policy_arns" {
  description = "IAM policies attached to the Terraform deployment role."
  type        = set(string)

  default = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
}

variable "github_oidc_url" {
  description = "GitHub Actions OIDC provider URL."
  type        = string
  default     = "https://token.actions.githubusercontent.com"
}

variable "github_oidc_client_ids" {
  description = "Client IDs accepted by the GitHub Actions OIDC provider."
  type        = list(string)
  default     = ["sts.amazonaws.com"]
}

variable "tags" {
  description = "Additional tags applied to IAM resources that support tagging."
  type        = map(string)
  default     = {}
}