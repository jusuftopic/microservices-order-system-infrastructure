data "tls_certificate" "github_actions_cert" {
  url = var.github_oidc_url
}

resource "aws_iam_openid_connect_provider" "github_actions" {
  url = var.github_oidc_url

  client_id_list = var.github_oidc_client_ids

  thumbprint_list = [
    data.tls_certificate.github_actions_cert.certificates[0].sha1_fingerprint
  ]

  tags = merge(
    local.common_tags,
    {
      IdentityType = "GitHubOIDCProvider"
    }
  )
}