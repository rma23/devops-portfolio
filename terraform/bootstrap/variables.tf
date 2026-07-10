variable "aws_region" {
  default = "ap-northeast-1"
}

variable "bucket_name" {
  default = "rma23-terraform-state"
}

variable "lock_table_name" {
  default = "terraform-lock"
}

variable "environment" {
  description = "Environment name"
  type = string
}

