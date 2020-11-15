terraform {
  source = "git@github.com:itd27m01-automation-solutions/gitlab-ci-aws-iam.git?ref=0.1.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  environment = "prod"
}