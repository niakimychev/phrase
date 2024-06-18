resource "aws_ecr_repository" "nginx" {
  name                 = var.ecr_repo_name
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "null_resource" "nginx_docker_image" {
  triggers = {
    image_version = "latest"
    image_id      = aws_ecr_repository.nginx.repository_url
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i localhost, ./ansible/build_push.yml"
    environment = {
      ECR_REPOSITORY_URL = aws_ecr_repository.nginx.repository_url
    }
  }
}
