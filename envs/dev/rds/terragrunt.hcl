terraform {
  source = "../../../../..//modules/gitlab-ci-aws-rds"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    gitlab_rds_sg_ids     = ["fake-rds-sg-ids"]
    gitlab_rds_subnet_ids = ["fake-rds-subnet-ids"]
  }
}

inputs = {
  environment            = "dev"
  gitlab_rds_db_flavor   = "db.m4.large"
  gitlab_rds_db_password = "123456789"
  gitlab_rds_sg_ids      = dependency.vpc.outputs.gitlab_rds_sg_ids
  gitlab_rds_subnet_ids  = dependency.vpc.outputs.gitlab_rds_subnet_ids
}