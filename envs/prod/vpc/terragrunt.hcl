locals {
  env_vars = yamldecode(file(find_in_parent_folders("env_vars.yaml")))
}

terraform {
  source = "git@github.com:itd27m01-automation-solutions/gitlab-ci-aws-vpc.git?ref=0.1.1"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  environment = "${local.env_vars.environment}"

  vpc_cidr = "10.${local.env_vars.subnet_number}.0.0/16"

  vpc_availability_zones = local.env_vars.availability_zones
  vpc_private_subnets = ["10.${local.env_vars.subnet_number}.4.0/22", "10.${local.env_vars.subnet_number}.8.0/22"]
  vpc_public_subnets  = ["10.${local.env_vars.subnet_number}.0.0/26", "10.${local.env_vars.subnet_number}.0.64/26"]

  vpc_database_subnets  = ["10.${local.env_vars.subnet_number}.1.0/26", "10.${local.env_vars.subnet_number}.1.64/26"]
  vpc_elasticache_subnets = ["10.${local.env_vars.subnet_number}.2.0/26", "10.${local.env_vars.subnet_number}.2.64/26"]
}
