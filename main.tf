locals {
  region = "eu-central-1"

  # nginx
  ecr_repo_name = "phrase-nginx-repo"
  image_tag     = "latest"

  # vpc
  vpc_cidr             = "10.0.0.0/16"
  availability_zones   = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  # ecs
  ecs_cluster_name = "phrase_nginx_cluster"

  #alb
  alb_name = "phrase-alb"
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
  public_subnet_cidrs  = local.public_subnet_cidrs
  availability_zones   = local.availability_zones
  private_subnet_cidrs = local.private_subnet_cidrs
}

module "ecs" {
  source = "./modules/ecs"

  vpc_id                = module.vpc.vpc_id
  region                = module.vpc.region
  private_subnets       = module.vpc.private_subnet_ids
  ecs_cluster_name      = local.ecs_cluster_name
  ecr_image             = "${module.nginx.ecr_repository_url}:${local.image_tag}"
  alb_sg                = module.alb.sg
  target_group_http_arn = module.alb.target_group_http_arn
}

module "alb" {
  source = "./modules/alb"

  vpc_id   = module.vpc.vpc_id
  subnets  = module.vpc.public_subnet_ids
  alb_name = local.alb_name
}

output "website_url" {
  value = format("Now you can open the website via: https://%s", module.alb.cloudfront_distribution_domain_name)
}
