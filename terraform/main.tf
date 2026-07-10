data "aws_availability_zones" "available" {}

module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  azs = slice(data.aws_availability_zones.available.names, 0, 2)
}

module "eks" {
  source = "./modules/eks"

  project_name = var.project_name
  environment  = var.environment

  cluster_name = var.cluster_name

  subnet_ids = module.vpc.private_subnet_ids

  node_instance_types = var.node_instance_types

  desired_size = var.desired_size
  min_size     = var.min_size
  max_size     = var.max_size

  github_actions_role_arn = module.github_actions.role_arn
  admin_principal_arn = var.admin_principal_arn
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = "${var.project_name}-app"
}

module "github_actions" {
  source = "./modules/github-actions"

  github_owner      = "rma23"
  github_repository = "devops-portfolio"

  role_name = "${var.project_name}-github-actions-role"
}
