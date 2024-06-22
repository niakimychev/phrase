output "alb_arn" {
  value       = aws_lb.alb.arn
  description = "The ARN of the ALB"
}

output "alb_dns_name" {
  value       = aws_lb.alb.dns_name
  description = "The DNS name of the ALB"
}

output "target_group_http_arn" {
  value       = aws_lb_target_group.http.arn
  description = "The ARN of http target group"
}

output "sg" {
  value       = aws_security_group.alb_sg.id
  description = "The ID of security group"
}
