locals {
  env_vars = yamldecode(file(find_in_parent_folders("env_vars.yaml")))
}

terraform {
  source = "../../../../..//modules/gitlab-ci-aws-iam"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  environment = "${local.env_vars.environment}"
}
