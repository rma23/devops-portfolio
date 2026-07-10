output "eks_cluster_name" {
  description = "EKS cluster name"

  value = module.infrastructure.eks_cluster_name
}


output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"

  value = module.infrastructure.eks_cluster_endpoint
}


output "ecr_repository_url" {
  description = "ECR repository URL"

  value = module.infrastructure.ecr_repository_url
}


output "github_actions_role_arn" {
  description = "GitHub Actions IAM Role ARN"

  value = module.infrastructure.github_actions_role_arn
}
