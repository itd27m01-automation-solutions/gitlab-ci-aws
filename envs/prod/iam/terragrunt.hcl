locals {
  env_vars = yamldecode(file(find_in_parent_folders("env_vars.yaml")))
}

terraform {
  source = "git@github.com:itd27m01-automation-solutions/gitlab-ci-aws-iam.git?ref=0.1.1"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  environment = "${local.env_vars.environment}"
}
