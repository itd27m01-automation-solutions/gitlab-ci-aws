locals {
  env_vars = yamldecode(file(find_in_parent_folders("env_vars.yaml")))
}

terraform {
  source = "git@github.com:itd27m01-automation-solutions/gitlab-ci-aws-gitaly.git?ref=0.1.1"
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

inputs = {
  environment = "${local.env_vars.environment}"

  gitlab_private_subnets  = dependency.vpc.outputs.gitlab_private_subnets
  gitlab_gitaly_sg_ids    = dependency.vpc.outputs.gitlab_gitaly_sg_ids
  gitlab_keypair          = dependency.vpc.outputs.gitlab_keypair

  gitlab_iam_profile_name = dependency.iam.outputs.gitlab_iam_profile_name
}
