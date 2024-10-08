locals {
  subnets_cidrs = cidrsubnets(var.vpc_cidr, 4, 4, 4, 4)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name            = "kubernetes-vpc"
  cidr            = var.vpc_cidr
  azs             = formatlist("${var.region}%s", ["a", "b"])
  private_subnets = slice(local.subnets_cidrs, 0, 2)
  public_subnets  = slice(local.subnets_cidrs, 2, 4)

  manage_default_security_group = false
  map_public_ip_on_launch       = true
  enable_nat_gateway            = true
  single_nat_gateway            = true

  tags = var.tags
}