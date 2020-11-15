terraform {
  source = "../../../../..//modules/gitlab-ci-aws-redis"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    vpc_id                               = ["fake-vpc-id"]
    gitlab_redis_sg_ids                  = ["fake-redis-sg-ids"]
    gitlab_elasticache_subnet_group_name = ["fake-redis-subnet-name"]
  }
}

inputs = {
  environment               = "dev"
  gitlab_vpc_id             = dependency.vpc.outputs.vpc_id
  gitlab_availability_zones = dependency.vpc.outputs.gitlab_availability_zones
  gitlab_redis_sg_ids       = dependency.vpc.outputs.gitlab_redis_sg_ids

  gitlab_elasticache_subnet_group_name = dependency.vpc.outputs.gitlab_elasticache_subnet_group_name
}