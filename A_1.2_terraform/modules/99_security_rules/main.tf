locals {
  name                       = "${var.prefix}_flarie_studio"
  prefix                     = var.prefix
  aws_region                 = var.aws_region
  eks_node_sg                = var.eks_node_sg
  aurora_sg                  = var.aurora_sg
  redis_sg                   = var.redis_sg
  eks_cluster_sg             = var.eks_cluster_sg
  allowed_cidr_for_db_access = var.allowed_cidr_for_db_access
}