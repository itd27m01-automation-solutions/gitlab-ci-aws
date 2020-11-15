terraform {
  source = "../../../../..//modules/gitlab-ci-aws-iam"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  environment = "dev"
}