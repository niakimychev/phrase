output "ecr_repository_url" {
  value       = aws_ecr_repository.nginx.repository_url
  description = "URL of the ECR repository"
}
