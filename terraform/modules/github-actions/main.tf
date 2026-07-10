####################################
# GitHub OIDC Provider
####################################

data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "github" {

  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    data.tls_certificate.github.certificates[0].sha1_fingerprint
  ]

}

####################################
# IAM Role
####################################

resource "aws_iam_role" "github_actions" {

  name = var.role_name

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Principal = {

          Federated = aws_iam_openid_connect_provider.github.arn

        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {

          StringEquals = {

            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"

          }

          StringLike = {

            "token.actions.githubusercontent.com:sub" = "repo:${var.github_owner}/${var.github_repository}:*"

          }
        }
      }
    ]
  })
}

####################################
# Policy
####################################

resource "aws_iam_role_policy" "github_actions" {

  name = "${var.role_name}-policy"

  role = aws_iam_role.github_actions.id

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
          "eks:DescribeCluster"	  
        ]

        Resource = "*"
      }
    ]
  })
}
