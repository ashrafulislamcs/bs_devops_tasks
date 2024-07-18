locals {
  eks_name     = "${var.prefix}-eks"
  prefix       = var.prefix
  aws_region   = var.aws_region
  namespace    = var.namespace
  backend_host = var.backend_host
  domain_name  = var.domain_name
  subdomain    = "${var.prefix}-api"
  common_tags = {
    Environment = var.prefix
    Project     = "flarie"
  }

  alb_certificate_arn                    = var.alb_certificate_arn
  eks_cluster_id                         = var.eks_cluster_id
  eks_cluster_endpoint                   = var.eks_cluster_endpoint
  aurora_cluster_endpoint                = var.aurora_cluster_endpoint
  aurora_cluster_read_endpoint           = var.aurora_cluster_read_endpoint
  redis_cluster_address                  = var.redis_cluster_address
  eks_cluster_certificate_authority_data = var.eks_cluster_certificate_authority_data
}

data "aws_route53_zone" "this" {
  name = local.domain_name
}