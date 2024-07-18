locals {
  vpc_name = "${var.prefix}-test-vpc"
  vpc_cidr = var.vpc_cidr
  prefix   = var.prefix
  common_tags = {
    Environment = "${var.prefix}"
    Project     = "test"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = local.vpc_name
  cidr = local.vpc_cidr

  azs = ["${var.aws_region}a", "${var.aws_region}b"]

  # public_subnet_suffix = "public"
  map_public_ip_on_launch = true
  public_subnets = [
    cidrsubnet(var.vpc_cidr, 8, 0),
    cidrsubnet(var.vpc_cidr, 8, 1)
  ]

  # private_subnet_suffix = "private"
  private_subnets = [
    cidrsubnet(var.vpc_cidr, 8, 2),
    cidrsubnet(var.vpc_cidr, 8, 3),
    # cidrsubnet(var.vpc_cidr, 8, 4),
    # cidrsubnet(var.vpc_cidr, 8, 5)
  ]

  # intra_subnets = [
  #   cidrsubnet(var.vpc_cidr, 8, 8),
  #   cidrsubnet(var.vpc_cidr, 8, 9)
  # ]
  # create_database_subnet_group           = true
  # create_database_internet_gateway_route = true
  # create_database_nat_gateway_route      = true
  # database_subnet_group_name             = "${local.prefix}-db-subnet"
  # database_subnet_names                  = ["${local.prefix}-database-subnet-1", "${local.prefix}-database-subnet-2"]

  # database_subnets = [
  #   cidrsubnet(var.vpc_cidr, 8, 4),
  #   cidrsubnet(var.vpc_cidr, 8, 5)
  # ]

  create_elasticache_subnet_group = true
  elasticache_subnet_suffix       = "elasticache"
  elasticache_subnets = [
    cidrsubnet(var.vpc_cidr, 8, 6),
    cidrsubnet(var.vpc_cidr, 8, 7)
  ]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  enable_dns_hostnames   = true
  enable_dns_support     = true
  one_nat_gateway_per_az = false

  tags = local.common_tags

  public_subnet_tags = {
    "kubernetes.io/role/elb"                  = "1"
    "kubernetes.io/cluster/${var.prefix}-eks" = "owned"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"         = "1"
    "kubernetes.io/cluster/${var.prefix}-eks" = "owned"
  }
}
