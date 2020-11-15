terraform {
  source = "../../../../..//modules/gitlab-ci-aws-app"
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
  environment = "dev"

  gitlab_vpc_id           = dependency.vpc.outputs.vpc_id
  gitlab_private_subnets  = dependency.vpc.outputs.gitlab_private_subnets
  gitlab_public_subnets   = dependency.vpc.outputs.gitlab_public_subnets
  gitlab_lb_sg_ids        = dependency.vpc.outputs.gitlab_lb_sg_ids
  gitlab_iam_profile_name = dependency.iam.outputs.gitlab_iam_profile_name

  gitlab_acm_certificate_arn = "arn:aws:acm:us-east-1:928913696904:certificate/079a3150-4ff3-4c35-9363-b3c63e4337ce"
}
