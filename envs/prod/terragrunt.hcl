locals {
  env_vars = yamldecode(file("env_vars.yaml"))
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "${local.env_vars.aws_profile}-terraform-state"
    key            = "${local.env_vars.environment}/${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.env_vars.aws_region}"
    encrypt        = true
    dynamodb_table = "${local.env_vars.aws_dynamodb_table}"
    profile        = "${local.env_vars.aws_profile}"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region  = "${local.env_vars.aws_region}"
  profile = "${local.env_vars.aws_profile}"
}
EOF
}
