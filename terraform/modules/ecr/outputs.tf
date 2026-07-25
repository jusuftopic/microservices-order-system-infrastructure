output "repository_names" {
  description = "ECR repository names keyed by service name."
  value = {
    for service_name, repository in aws_ecr_repository.service :
    service_name => repository.name
  }
}

output "repository_arns" {
  description = "ECR repository ARNs keyed by service name."
  value = {
    for service_name, repository in aws_ecr_repository.service :
    service_name => repository.arn
  }
}

output "repository_urls" {
  description = "ECR repository URLs keyed by service name."
  value = {
    for service_name, repository in aws_ecr_repository.service :
    service_name => repository.repository_url
  }
}
