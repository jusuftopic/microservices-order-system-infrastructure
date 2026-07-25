variable "repository_name_prefix" {
  description = "Namespace prepended to every service repository name."
  type        = string
  default     = "microservices-order-system"

  validation {
    condition = (
    length(trimspace(var.repository_name_prefix)) > 0 &&
    can(regex("^[a-z0-9]+(?:[._/-][a-z0-9]+)*$", var.repository_name_prefix))
    )
    error_message = "repository_name_prefix must be a valid lowercase ECR repository namespace."
  }
}

variable "service_names" {
  description = "Service names for which private ECR repositories are created."
  type        = set(string)

  default = [
    "order-service",
    "inventory-service",
    "payment-service",
    "notification-service"
  ]

  validation {
    condition = (
    length(var.service_names) > 0 &&
    alltrue([
      for service_name in var.service_names :
      can(regex("^[a-z0-9]+(?:[._/-][a-z0-9]+)*$", service_name))
    ])
    )
    error_message = "service_names must contain valid lowercase ECR repository name segments."
  }
}

variable "max_image_count" {
  description = "Maximum number of images retained in each repository."
  type        = number
  default     = 2

  validation {
    condition     = var.max_image_count >= 1 && floor(var.max_image_count) == var.max_image_count
    error_message = "max_image_count must be a positive integer."
  }
}

variable "image_tag_mutability" {
  description = "Whether existing image tags can be overwritten."
  type        = string
  default     = "IMMUTABLE"

  validation {
    condition     = contains(["IMMUTABLE", "MUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutability must be IMMUTABLE or MUTABLE."
  }
}

variable "scan_on_push" {
  description = "Run ECR basic vulnerability scanning when an image is pushed."
  type        = bool
  default     = true
}

variable "force_delete" {
  description = "Allow Terraform to delete non-empty repositories. Disabled by default to protect images."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags applied to all ECR repositories."
  type        = map(string)
  default     = {}
}
