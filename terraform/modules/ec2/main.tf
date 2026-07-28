data "aws_ssm_parameter" "default_ami" {
  count = var.ami_id == null ? 1 : 0

  name = var.ami_ssm_parameter_name
}

locals {
  ami_id = var.ami_id != null ? var.ami_id : data.aws_ssm_parameter.default_ami[0].value

  common_tags = merge(
    {
      Component = "EC2"
      ManagedBy = "Terraform"
    },
    var.tags
  )
}

resource "aws_instance" "this" {
  ami                         = local.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  iam_instance_profile        = var.instance_profile_name
  associate_public_ip_address = var.associate_public_ip_address
  monitoring                  = var.detailed_monitoring
  user_data                   = var.user_data
  user_data_replace_on_change = var.user_data_replace_on_change

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "disabled"
  }

  root_block_device {
    encrypted             = true
    delete_on_termination = var.root_volume_delete_on_termination
    volume_type           = "gp3"
    volume_size           = var.root_volume_size

    tags = merge(
      local.common_tags,
      {
        Name = "${var.name}-root"
      }
    )
  }

  tags = merge(
    local.common_tags,
    {
      Name = var.name
    }
  )
}