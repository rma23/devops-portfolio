####################################
# EKS Access Entry
####################################

resource "aws_eks_access_entry" "github_actions" {
  cluster_name = aws_eks_cluster.main.name
  principal_arn = var.github_actions_role_arn
  type = "STANDARD"
}

resource "aws_eks_access_entry" "admin" {
  cluster_name = aws_eks_cluster.main.name
  principal_arn = var.admin_principal_arn
  type = "STANDARD"
}

####################################
# EKS Access Policy Association
####################################

resource "aws_eks_access_policy_association" "github_actions_admin" {
  cluster_name = aws_eks_cluster.main.name
  principal_arn = var.github_actions_role_arn
  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [
    aws_eks_access_entry.github_actions
  ]
}


resource "aws_eks_access_policy_association" "admin" {
  cluster_name = aws_eks_cluster.main.name
  principal_arn = var.admin_principal_arn
  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [
    aws_eks_access_entry.admin
  ]
}
