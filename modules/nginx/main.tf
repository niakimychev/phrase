resource "aws_ecr_repository" "nginx" {
  name                 = var.ecr_repo_name
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "null_resource" "nginx_docker_image" {
  triggers = {
    image_version = var.image_tag
    image_id      = aws_ecr_repository.nginx.repository_url
    region        = var.region
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i localhost, ${path.module}/ansible/build_push.yml -e ECR_REPOSITORY_URL=${self.triggers.image_id} -e IMAGE_VERSION=${self.triggers.image_version} -e REGION=${self.triggers.region}"
  }
}
