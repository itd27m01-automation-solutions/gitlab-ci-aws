locals {
  env_vars = yamldecode(file(find_in_parent_folders("env_vars.yaml")))
}

terraform {
  source = "../../../../..//modules/gitlab-ci-aws-redis"
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