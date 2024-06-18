provider "aws" {
  region = "eu-central-1"
}

module "vpc" {
  source = "./modules/vpc"

  region               = "eu-central-1"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidr   = "10.0.1.0/24"
  availability_zones   = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  private_subnet_cidrs = ["10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}

module "ecs" {
  source = "./modules/ecs"

  vpc_id           = module.vpc.vpc_id
  region           = module.vpc.region
  private_subnets  = module.vpc.private_subnet_ids
  ecs_cluster_name = "phrase_nginx_cluster"

  depends_on = [
    module.vpc
  ]
}
