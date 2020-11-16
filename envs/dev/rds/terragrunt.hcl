locals {
  env_vars = yamldecode(file(find_in_parent_folders("env_vars.yaml")))
}

terraform {
  source = "../../../../..//modules/gitlab-ci-aws-rds"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  environment = "${local.env_vars.environment}"

  gitlab_rds_db_flavor   = "db.m4.large"
  gitlab_rds_db_password = "123456789"
  gitlab_rds_sg_ids      = dependency.vpc.outputs.gitlab_rds_sg_ids
  gitlab_rds_subnet_ids  = dependency.vpc.outputs.gitlab_rds_subnet_ids
}