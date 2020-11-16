locals {
  env_vars = yamldecode(file(find_in_parent_folders("env_vars.yaml")))
}

terraform {
  source = "git@github.com:itd27m01-automation-solutions/gitlab-ci-aws-redis.git?ref=0.1.0"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  environment = "${local.env_vars.environment}"

  gitlab_vpc_id             = dependency.vpc.outputs.vpc_id
  gitlab_availability_zones = dependency.vpc.outputs.gitlab_availability_zones
  gitlab_redis_sg_ids       = dependency.vpc.outputs.gitlab_redis_sg_ids

  gitlab_elasticache_subnet_group_name = dependency.vpc.outputs.gitlab_elasticache_subnet_group_name
}