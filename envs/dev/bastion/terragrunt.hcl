locals {
  env_vars = yamldecode(file(find_in_parent_folders("env_vars.yaml")))
}

terraform {
  source = "../../../../..//modules/gitlab-ci-aws-bastion"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  environment = "${local.env_vars.environment}"

  gitlab_public_subnets  = dependency.vpc.outputs.gitlab_public_subnets
  gitlab_bastion_sg_ids  = dependency.vpc.outputs.gitlab_bastion_sg_ids
  gitlab_keypair         = dependency.vpc.outputs.gitlab_keypair
}
