terraform {
  source = "git@github.com:itd27m01-automation-solutions/gitlab-ci-aws-vpc.git?ref=0.1.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  environment = "prod"

  vpc_cidr = "10.2.0.0/16"

  vpc_availability_zones = ["us-east-1a", "us-east-1b"]
  vpc_private_subnets = ["10.2.4.0/22", "10.2.8.0/22"]
  vpc_public_subnets  = ["10.2.0.0/26", "10.2.0.64/26"]

  vpc_database_subnets  = ["10.2.1.0/26", "10.2.1.64/26"]
  vpc_elasticache_subnets = ["10.2.2.0/26", "10.2.2.64/26"]
}