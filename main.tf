locals {
  region = "eu-central-1"

  # nginx
  ecr_repo_name = "phrase-nginx-repo"
  image_tag     = "latest"

  # vpc
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidr   = "10.0.1.0/24"
  availability_zones   = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  private_subnet_cidrs = ["10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]

  # ecs
  ecs_cluster_name = "phrase_nginx_cluster"
}

provider "aws" {
  region = local.region
}

module "nginx" {
  source = "./modules/nginx"

  private_route_table_ids = [module.vpc.private_route_table_id]
  private_subnet_ids      = module.vpc.private_subnet_ids
  vpc_id                  = module.vpc.vpc_id
  sg_id                   = module.ecs.sg_id

  ecr_repo_name = local.ecr_repo_name
  image_tag     = local.image_tag
  region        = local.region
}

module "vpc" {
  source = "./modules/vpc"

  region               = local.region
  vpc_cidr             = local.vpc_cidr
  public_subnet_cidr   = local.public_subnet_cidr
  availability_zones   = local.availability_zones
  private_subnet_cidrs = local.private_subnet_cidrs
}

module "ecs" {
  source = "./modules/ecs"

  vpc_id           = module.vpc.vpc_id
  region           = module.vpc.region
  private_subnets  = module.vpc.private_subnet_ids
  ecs_cluster_name = local.ecs_cluster_name
  ecr_image        = "${module.nginx.ecr_repository_url}:${local.image_tag}"
}
