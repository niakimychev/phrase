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
  type        = string
}

variable "ecr_image" {
  description = "ECR Image url"
  type        = string
}

variable "alb_sg" {
  description = "ID of alb security group"
  type        = string
}

# variable "target_group_http_arn" {
#   description = "ARN of http target group"
#   type        = string
# }

variable "target_group_https_arn" {
  description = "ARN of https target group"
  type        = string
}
