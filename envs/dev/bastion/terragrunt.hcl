terraform {
  source = "../../../../..//modules/gitlab-ci-aws-bastion"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "app" {
  config_path = "../app"
}

inputs = {
  environment = "dev"

  gitlab_public_subnets  = dependency.vpc.outputs.gitlab_public_subnets
  gitlab_bastion_sg_ids  = dependency.vpc.outputs.gitlab_bastion_sg_ids

  gitlab_keypair = dependency.app.outputs.gitlab_keypair
}
