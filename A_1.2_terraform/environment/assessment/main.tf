module "vpc" {
  source     = "../../modules/1_vpc"
  prefix     = var.prefix
  vpc_cidr   = var.vpc_cidr
  aws_region = var.aws_region
}

module "eks" {
  source                = "../../modules/5_eks"
  prefix                = var.prefix
  aws_region            = var.aws_region
  vpc_id                = module.vpc.vpc_id
  private_subnets       = module.vpc.private_subnets
  namespace             = var.namespace
  backend_host          = var.backend_host
  default_instance_type = var.instance_type
}

module "sg" {
  source     = "../../modules/99_security_rules"
  aws_region = var.aws_region
  prefix     = var.prefix

  eks_node_sg                = module.eks.node_security_group_id
  eks_cluster_sg             = module.eks.cluster_security_group_id
}

module "test_k8s" {
  source              = "../../modules/5.1_test_k8s"
  prefix              = var.prefix
  aws_region          = var.aws_region
  namespace           = var.namespace
  backend_host        = var.backend_host
  alb_certificate_arn = var.alb_certificate_arn
  domain_name         = var.domain_name

  eks_cluster_endpoint                   = module.eks.cluster_endpoint
  eks_cluster_certificate_authority_data = module.eks.cluster_certificate_authority_data
  eks_cluster_id                         = module.eks.cluster_id
}
