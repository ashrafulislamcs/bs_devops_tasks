##########
# loadbalancer
##########
data "aws_lb" "alb" {
  tags = {
    "elbv2.k8s.aws/cluster"    = local.eks_cluster_id
    "ingress.k8s.aws/resource" = "LoadBalancer"
    "ingress.k8s.aws/stack"    = "${local.namespace}/flarie-ingress"
  }
}