# Amazon ECR

The ECR Terraform module creates one private container repository for each
business service:

- `microservices-order-system/order-service`
- `microservices-order-system/inventory-service`
- `microservices-order-system/payment-service`
- `microservices-order-system/notification-service`

Creating multiple private repositories has no separate per-repository charge.
Amazon ECR charges for the total storage consumed and for applicable data
transfer. All four repositories therefore share the account's ECR free-tier
allowance rather than receiving an allowance individually.

## Repository configurations

The module uses the following defaults:

- AES-256 encryption managed by ECR, avoiding a customer-managed KMS key.
- A maximum of two images per service repository.
- A maximum of one untagged image per service repository.
- Basic image scanning on push.
- Immutable image tags so a deployed tag always identifies the same image.
- No registry replication configuration.

Lifecycle policies expire older images after they exceed these limits. ECR
normally applies an eligible lifecycle expiration within 24 hours, so storage
can temporarily exceed the configured image count.

## Usage

```hcl
module "ecr" {
  source = "../../modules/ecr"

  repository_name_prefix = "microservices-order-system"
  max_image_count         = 2

  tags = {
    Project     = "microservices-order-system"
    Environment = "dev"
  }
}
```

The module uses `aws_ecr_repository`, which creates private repositories. It
does not create public ECR resources or an ECR registry replication
configuration.