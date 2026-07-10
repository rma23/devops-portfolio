module "infrastructure" {
  source = "../.."

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  cluster_name        = var.cluster_name
  node_instance_types = var.node_instance_types

  desired_size = var.desired_size
  min_size     = var.min_size
  max_size     = var.max_size

  admin_principal_arn = var.admin_principal_arn
}
