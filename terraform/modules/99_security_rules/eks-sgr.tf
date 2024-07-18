resource "aws_security_group_rule" "eks-node-ingress-10250-self" {
  type                     = "ingress"
  protocol                 = "tcp"
  description              = "custom metrics-server ingress (self)"
  from_port                = 10250
  to_port                  = 10250
  security_group_id        = local.eks_node_sg
  source_security_group_id = local.eks_node_sg
}
# resource "aws_security_group_rule" "eks-node-ingress-10250-cluster" {
#   type                     = "ingress"
#   protocol                 = "tcp"
#   description              = "custom metrics-server ingress (cluster)"
#   from_port                = 10250
#   to_port                  = 10250
#   security_group_id        = local.eks_node_sg
#   source_security_group_id = local.eks_cluster_sg
# }
resource "aws_security_group_rule" "eks-node-ingress-4443-cluster" {
  type                     = "ingress"
  protocol                 = "tcp"
  description              = "custom metrics-server ingress (cluster)"
  from_port                = 4443
  to_port                  = 4443
  security_group_id        = local.eks_node_sg
  source_security_group_id = local.eks_cluster_sg
}

resource "aws_security_group_rule" "eks-cluster-egress-4443-node" {
  type                     = "egress"
  protocol                 = "tcp"
  description              = "custom metrics-server egress (cluster)"
  from_port                = 4443
  to_port                  = 4443
  security_group_id        = local.eks_node_sg
  source_security_group_id = local.eks_cluster_sg
}
resource "aws_security_group_rule" "eks-node-egress-10250-cluster" {
  type                     = "egress"
  protocol                 = "tcp"
  description              = "custom metrics-server egress (cluster)"
  from_port                = 10250
  to_port                  = 10250
  security_group_id        = local.eks_node_sg
  source_security_group_id = local.eks_cluster_sg
}
resource "aws_security_group_rule" "eks-node-egress-10250-self" {
  type                     = "egress"
  protocol                 = "tcp"
  description              = "custom metrics-server egress (self)"
  from_port                = 10250
  to_port                  = 10250
  security_group_id        = local.eks_node_sg
  source_security_group_id = local.eks_node_sg
}
resource "aws_security_group_rule" "eks-cluster-ingress-4443-node" {
  type                     = "ingress"
  protocol                 = "tcp"
  description              = "custom metrics-server ingress (cluster)"
  from_port                = 4443
  to_port                  = 4443
  security_group_id        = local.eks_cluster_sg
  source_security_group_id = local.eks_node_sg
}
resource "aws_security_group_rule" "eks-cluster-ingress-10250-node" {
  type                     = "ingress"
  protocol                 = "tcp"
  description              = "custom metrics-server ingress (cluster)"
  from_port                = 10250
  to_port                  = 10250
  security_group_id        = local.eks_cluster_sg
  source_security_group_id = local.eks_node_sg
}












# # eks-node-group -> self -> metrics-server



# # eks-node-group -> cluster -> metrics-server

# resource "aws_security_group_rule" "eks-cluster-egress-10250-node" {
#   type                     = "egress"
#   protocol                 = "tcp"
#   description              = "custom metrics-server egress (cluster)"
#   from_port                = 10250
#   to_port                  = 10250
#   security_group_id        = local.eks_cluster_sg
#   source_security_group_id = local.eks_node_sg
# }



# resource "aws_security_group_rule" "eks-cluster-ingress-10250-node" {
#   type                     = "ingress"
#   protocol                 = "tcp"
#   description              = "custom metrics-server ingress (cluster)"
#   from_port                = 10250
#   to_port                  = 10250
#   security_group_id        = local.eks_cluster_sg
#   source_security_group_id = local.eks_node_sg
# }

# # eks-node-group -> cluster -> metrics-server



# resource "aws_security_group_rule" "eks-cluster-ingress-10250-node" {
#   type                     = "ingress"
#   protocol                 = "tcp"
#   description              = "custom metrics-server ingress (cluster)"
#   from_port                = 10250
#   to_port                  = 10250
#   security_group_id        = local.eks_node_sg
#   source_security_group_id = local.eks_cluster_sg
# }
# resource "aws_security_group_rule" "eks-cluster-egress-10250-node" {
#   type                     = "egress"
#   protocol                 = "tcp"
#   description              = "custom metrics-server egress (cluster)"
#   from_port                = 10250
#   to_port                  = 10250
#   security_group_id        = local.eks_node_sg
#   source_security_group_id = local.eks_cluster_sg
# }

# resource "aws_security_group_rule" "eks-node-ingress-for-metrics-server-self-4443" {
#   type                     = "ingress"
#   protocol                 = "tcp"
#   description              = "custom ingress rule for metrics server (self) 4443"
#   from_port                = 4443
#   to_port                  = 4443
#   security_group_id        = local.eks_node_sg
#   source_security_group_id = local.eks_node_sg
# }
# resource "aws_security_group_rule" "eks-node-egress-for-metrics-server-self-4443" {
#   type                     = "egress"
#   protocol                 = "tcp"
#   description              = "custom egress rule for metrics server (self) 4443"
#   from_port                = 4443
#   to_port                  = 4443
#   security_group_id        = local.eks_node_sg
#   source_security_group_id = local.eks_node_sg
# }

# resource "aws_security_group_rule" "eks-node-ingress-for-metrics-server-self" {
#   type                     = "ingress"
#   protocol                 = "tcp"
#   description              = "custom ingress rule for metrics server (self)"
#   from_port                = 10250
#   to_port                  = 10250
#   security_group_id        = local.eks_node_sg
#   source_security_group_id = local.eks_node_sg
# }
# resource "aws_security_group_rule" "eks-node-ingress-for-metrics-server-cluster-4443" {
#   type                     = "ingress"
#   protocol                 = "tcp"
#   description              = "custom ingress rule for metrics server (cluster)"
#   from_port                = 4443
#   to_port                  = 4443
#   security_group_id        = local.eks_node_sg
#   source_security_group_id = local.eks_cluster_sg
# }

# resource "aws_security_group_rule" "eks-node-egress-for-metrics-server-self" {
#   type                     = "egress"
#   protocol                 = "tcp"
#   description              = "custom egress rule for metrics server (self)"
#   from_port                = 10250
#   to_port                  = 10250
#   security_group_id        = local.eks_node_sg
#   source_security_group_id = local.eks_node_sg
# }

# resource "aws_security_group_rule" "eks-node-egress-for-metrics-server-4443" {
#   type                     = "egress"
#   protocol                 = "tcp"
#   description              = "custom egress rule for metrics server (cluster) over 4443"
#   from_port                = 4443
#   to_port                  = 4443
#   security_group_id        = local.eks_node_sg
#   source_security_group_id = local.eks_cluster_sg
# }