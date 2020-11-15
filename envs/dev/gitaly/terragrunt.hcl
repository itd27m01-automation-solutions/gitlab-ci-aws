terraform {
  source = "../../../../..//modules/gitlab-ci-aws-gitaly"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "iam" {
  config_path = "../iam"
}

dependency "app" {
  config_path = "../app"
}

inputs = {
  environment = "dev"

  gitlab_private_subnets  = dependency.vpc.outputs.gitlab_private_subnets
  gitlab_gitaly_sg_ids    = dependency.vpc.outputs.gitlab_gitaly_sg_ids

  gitlab_iam_profile_name = dependency.iam.outputs.gitlab_iam_profile_name

  gitlab_keypair          = dependency.app.outputs.gitlab_keypair
}
