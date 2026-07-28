output "instance_id" {
  description = "ID of the EC2 instance."
  value       = aws_instance.this.id
}

output "instance_arn" {
  description = "ARN of the EC2 instance."
  value       = aws_instance.this.arn
}

output "availability_zone" {
  description = "Availability Zone in which the instance was launched."
  value       = aws_instance.this.availability_zone
}

output "private_ip" {
  description = "Private IPv4 address of the instance."
  value       = aws_instance.this.private_ip
}

output "public_ip" {
  description = "Public IPv4 address when one is assigned."
  value       = aws_instance.this.public_ip
}

output "ami_id" {
  description = "AMI used to launch the instance."
  value       = aws_instance.this.ami
}
