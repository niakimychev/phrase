variable "region" {
  description = "AWS region to deploy the ECS"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs for ECS service"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
}

variable "ecr_image" {
  description = "ECR Image url"
  type        = string
}

