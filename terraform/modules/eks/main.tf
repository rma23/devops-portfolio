
####################################
# EKS Cluster IAM Role
####################################

resource "aws_iam_role" "eks_cluster" {
  name = "${var.project_name}-${var.environment}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "eks.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

####################################
# Node Group IAM Role
####################################

resource "aws_iam_role" "eks_node" {
  name = "${var.project_name}-${var.environment}-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "worker_node" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "cni" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ecr" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

####################################
# EKS Cluster
####################################

resource "aws_eks_cluster" "main" {

  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn

  version = "1.30"

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  vpc_config {

    subnet_ids = var.subnet_ids

    endpoint_private_access = true
    endpoint_public_access  = true

  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_cloudwatch_log_group.eks
  ]

  tags = {
    Name = var.cluster_name
  }
}

####################################
# Managed Node Group
####################################

resource "aws_eks_node_group" "main" {

  cluster_name = aws_eks_cluster.main.name

  node_group_name = "${var.project_name}-nodegroup"

  node_role_arn = aws_iam_role.eks_node.arn

  subnet_ids = var.subnet_ids

  instance_types = var.node_instance_types

  capacity_type = "ON_DEMAND"

  scaling_config {

    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size

  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.worker_node,
    aws_iam_role_policy_attachment.cni,
    aws_iam_role_policy_attachment.ecr
  ]

  tags = {
    Name = "${var.project_name}-nodegroup"
  }
}

####################################
# CloudWatch Log Group
####################################

resource "aws_cloudwatch_log_group" "eks" {

  name = "/aws/eks/${var.cluster_name}/cluster"

  retention_in_days = 30

  tags = {

    Name = "${var.cluster_name}-logs"

  }

}

####################################
# EKS Addons
####################################

resource "aws_eks_addon" "vpc_cni" {

  cluster_name = aws_eks_cluster.main.name

  addon_name = "vpc-cni"

  resolve_conflicts_on_create = "OVERWRITE"

  resolve_conflicts_on_update = "OVERWRITE"

  tags = {
    Name = "${var.cluster_name}-vpc-cni"
  }

  depends_on = [
    aws_eks_node_group.main
  ]
}


resource "aws_eks_addon" "kube_proxy" {

  cluster_name = aws_eks_cluster.main.name

  addon_name = "kube-proxy"

  resolve_conflicts_on_create = "OVERWRITE"

  resolve_conflicts_on_update = "OVERWRITE"

  tags = {
    Name = "${var.cluster_name}-kube-proxy"
  }

  depends_on = [
    aws_eks_node_group.main
  ]
}


resource "aws_eks_addon" "coredns" {

  cluster_name = aws_eks_cluster.main.name

  addon_name = "coredns"

  resolve_conflicts_on_create = "OVERWRITE"

  resolve_conflicts_on_update = "OVERWRITE"

  tags = {
    Name = "${var.cluster_name}-coredns"
  }

  depends_on = [
    aws_eks_node_group.main
  ]
}
