output "ecs_cluster_id" {
  value = aws_ecs_cluster.nginx_cluster.id
}

output "ecs_service_name" {
  value = aws_ecs_service.nginx_service.name
}

output "sg_id" {
  value = aws_security_group.nginx_sg.id
}
