variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "devops-portfolio"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-northeast-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)

  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)

  default = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
  default     = "portfolio-eks"
}

variable "node_instance_type" {
  description = "EKS Node Instance Type"
  type        = string
  default     = "t3.medium"
}

variable "desired_size" {
  type    = number
  default = 2
}

variable "min_size" {
  type    = number
  default = 1
}

variable "max_size" {
  type    = number
  default = 3
}

variable "node_instance_types" {
  description = "EKS worker node instance types"
  type = list(string)
}

variable "admin_principal_arn" {
  description = "IAM principal ARN for EKS access"
  type = string
}
