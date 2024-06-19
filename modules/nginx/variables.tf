variable "ecr_repo_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "image_tag" {
  description = "Image tag"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}
