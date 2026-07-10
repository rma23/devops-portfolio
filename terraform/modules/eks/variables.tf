variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
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

variable "github_actions_role_arn" {
  description = "IAM Role ARN used by GitHub Actions"
  type        = string
}

variable "admin_principal_arn" {
  description = "Admin IAM principal ARN"
  type        = string
}
