terraform {
  source = "../../../../..//modules/gitlab-ci-aws-vpc"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  environment = "dev"

  vpc_cidr = "192.168.0.0/16"

  vpc_availability_zones = ["us-east-1a", "us-east-1b"]
  vpc_private_subnets = ["192.168.1.0/26", "192.168.1.64/26"]
  vpc_public_subnets  = ["192.168.2.0/24", "192.168.3.0/24"]

  vpc_database_subnets  = ["192.168.4.0/25", "192.168.4.128/25"]
  vpc_elasticache_subnets = ["192.168.5.0/25", "192.168.5.128/25"]
}