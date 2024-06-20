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

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "private_route_table_ids" {
  description = "Private RT IDs"
  type        = list(string)
}

variable "sg_id" {
  description = "Security Group ID"
  type        = string
}
