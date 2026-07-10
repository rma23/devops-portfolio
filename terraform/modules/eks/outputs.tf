####################################
# EKS Cluster
####################################

output "cluster_name" {

  description = "EKS cluster name"

  value = aws_eks_cluster.main.name

}


output "cluster_endpoint" {

  description = "EKS cluster endpoint"

  value = aws_eks_cluster.main.endpoint

}


output "cluster_arn" {

  description = "EKS cluster ARN"

  value = aws_eks_cluster.main.arn

}


output "cluster_ca_certificate" {

  description = "EKS cluster CA certificate"

  value = aws_eks_cluster.main.certificate_authority[0].data

  sensitive = true

}


####################################
# Node Group
####################################

output "node_group_name" {

  description = "EKS node group name"

  value = aws_eks_node_group.main.node_group_name

}


output "node_group_arn" {

  description = "EKS node group ARN"

  value = aws_eks_node_group.main.arn

}


####################################
# OIDC
####################################

output "oidc_issuer_url" {

  description = "OIDC issuer URL"

  value = aws_eks_cluster.main.identity[0].oidc[0].issuer

}


####################################
# CloudWatch Logs
####################################

output "cloudwatch_log_group_name" {

  description = "EKS CloudWatch log group"

  value = aws_cloudwatch_log_group.eks.name

}
