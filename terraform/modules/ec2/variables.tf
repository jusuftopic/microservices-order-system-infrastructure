variable "name" {
  description = "Name assigned to the EC2 instance and its root volume."
  type        = string

  validation {
    condition     = length(trimspace(var.name)) > 0
    error_message = "name must not be empty."
  }
}

variable "instance_type" {
  description = "EC2 instance type. Keep this configurable so compute can be resized after measuring the workload."
  type        = string
  default     = "t3.micro"

  validation {
    condition     = length(trimspace(var.instance_type)) > 0
    error_message = "instance_type must not be empty."
  }
}

variable "ami_id" {
  description = "Explicit AMI ID. When null, ami_ssm_parameter_name is resolved instead."
  type        = string
  default     = null

  validation {
    condition     = var.ami_id == null || can(regex("^ami-[0-9a-f]+$", var.ami_id))
    error_message = "ami_id must be null or a valid AMI ID."
  }
}

variable "ami_ssm_parameter_name" {
  description = "SSM public parameter used to resolve the default AMI."
  type        = string
  default     = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"

  validation {
    condition     = startswith(var.ami_ssm_parameter_name, "/")
    error_message = "ami_ssm_parameter_name must be an absolute SSM parameter name."
  }
}

variable "subnet_id" {
  description = "Existing subnet in which the instance is launched. Networking is intentionally outside this module."
  type        = string

  validation {
    condition     = can(regex("^subnet-[0-9a-f]+$", var.subnet_id))
    error_message = "subnet_id must be a valid subnet ID."
  }
}

variable "security_group_ids" {
  description = "Existing security groups attached to the instance."
  type        = set(string)

  validation {
    condition = (
    length(var.security_group_ids) > 0 &&
    alltrue([for id in var.security_group_ids : can(regex("^sg-[0-9a-f]+$", id))])
    )
    error_message = "security_group_ids must contain at least one valid security group ID."
  }
}

variable "instance_profile_name" {
  description = "Existing IAM instance-profile name attached to EC2."
  type        = string

  validation {
    condition     = length(trimspace(var.instance_profile_name)) > 0
    error_message = "instance_profile_name must not be empty."
  }
}

variable "associate_public_ip_address" {
  description = "Whether the instance receives a public IPv4 address. Useful only for the temporary public-subnet design."
  type        = bool
  default     = true
}

variable "root_volume_size" {
  description = "Root gp3 volume size in GiB."
  type        = number
  default     = 30

  validation {
    condition     = var.root_volume_size >= 8 && floor(var.root_volume_size) == var.root_volume_size
    error_message = "root_volume_size must be an integer of at least 8 GiB."
  }
}

variable "root_volume_delete_on_termination" {
  description = "Whether the root volume is removed when the instance is terminated."
  type        = bool
  default     = true
}

variable "detailed_monitoring" {
  description = "Enable one-minute EC2 detailed monitoring. Disabled by default to avoid its additional cost."
  type        = bool
  default     = false
}

variable "user_data" {
  description = "Optional bootstrap configuration."
  type        = string
  default     = null
}

variable "user_data_replace_on_change" {
  description = "Replace the instance when user_data changes."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags applied to the EC2 instance and root volume."
  type        = map(string)
  default     = {}
}