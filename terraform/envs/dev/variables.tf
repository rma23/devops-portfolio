variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "node_instance_types" {
  type = list(string)
}

variable "desired_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "public_subnets" {
  description = "Public subnet CIDR list"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDR list"
  type        = list(string)
}

variable "admin_principal_arn" {
  description = "IAM principal ARN for EKS admin access"
  type        = string
}
