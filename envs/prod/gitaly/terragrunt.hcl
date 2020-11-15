terraform {
  source = "git@github.com:itd27m01-automation-solutions/gitlab-ci-aws-gitaly.git?ref=0.1.0"
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
  environment = "prod"

  gitlab_private_subnets  = dependency.vpc.outputs.gitlab_private_subnets
  gitlab_gitaly_sg_ids    = dependency.vpc.outputs.gitlab_gitaly_sg_ids

  gitlab_iam_profile_name = dependency.iam.outputs.gitlab_iam_profile_name

  gitlab_keypair          = dependency.app.outputs.gitlab_keypair
}
