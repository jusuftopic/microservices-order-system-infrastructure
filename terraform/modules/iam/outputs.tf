output "admin_user_name" {
  description = "Name of the administrator IAM user."
  value       = aws_iam_user.admin.name
}

output "admin_user_arn" {
  description = "ARN of the administrator IAM user."
  value       = aws_iam_user.admin.arn
}

output "terraform_deployer_role_name" {
  description = "Name of the Terraform deployment role."
  value       = aws_iam_role.terraform_deployer.name
}

output "terraform_deployer_role_arn" {
  description = "ARN of the Terraform deployment role."
  value       = aws_iam_role.terraform_deployer.arn
}

output "container_publisher_role_name" {
  description = "Name of the GitHub Actions container publisher role."
  value       = aws_iam_role.container_publisher.name
}

output "container_publisher_role_arn" {
  description = "ARN of the GitHub Actions container publisher role."
  value       = aws_iam_role.container_publisher.arn
}

output "container_runtime_role_name" {
  description = "Name of the EC2 container runtime role."
  value       = aws_iam_role.container_runtime.name
}

output "container_runtime_role_arn" {
  description = "ARN of the EC2 container runtime role."
  value       = aws_iam_role.container_runtime.arn
}

output "container_runtime_instance_profile_name" {
  description = "Name of the instance profile used by EC2 runtime instances."
  value       = aws_iam_instance_profile.container_runtime.name
}

output "container_runtime_instance_profile_arn" {
  description = "ARN of the instance profile used by EC2 runtime instances."
  value       = aws_iam_instance_profile.container_runtime.arn
}

output "github_oidc_provider_arn" {
  description = "ARN of the GitHub Actions OIDC provider."
  value       = aws_iam_openid_connect_provider.github_actions.arn
}