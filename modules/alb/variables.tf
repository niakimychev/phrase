variable "alb_name" {
  type        = string
  description = "The name of the ALB"
}

variable "subnets" {
  type        = list(string)
  description = "A list of subnet IDs to attach to the ALB"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where the ALB and target group are located"
}
