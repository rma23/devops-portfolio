variable "github_owner" {
  description = "GitHub organization or username"
  type        = string
}


variable "github_repository" {
  description = "GitHub repository name"
  type        = string
}


variable "role_name" {
  description = "IAM Role name for GitHub Actions"
  type        = string
}
