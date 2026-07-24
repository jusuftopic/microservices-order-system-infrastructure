output "terraform_role_arn" {
  value = module.iam.terraform_deployer_role_arn
}

output "publisher_role_arn" {
  value = module.iam.container_publisher_role_arn
}

output "runtime_instance_profile" {
  value = module.iam.container_runtime_instance_profile_name
}