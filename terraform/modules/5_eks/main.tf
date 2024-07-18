locals {
  eks_name              = "${var.prefix}-eks"
  prefix                = var.prefix
  eks_version           = "1.28"
  private_subnets       = var.private_subnets
  vpc_id                = var.vpc_id
  db_sg_id              = var.db_sg_id
  aws_region            = var.aws_region
  default_instance_type = var.default_instance_type
  namespace             = var.namespace
  backend_host          = var.backend_host
  common_tags = {
    Environment = var.prefix
    Project     = "flarie"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"
  # version = "20.2.1"

  cluster_name    = local.eks_name
  cluster_version = local.eks_version

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id                   = local.vpc_id
  subnet_ids               = local.private_subnets
  control_plane_subnet_ids = local.private_subnets

  enable_irsa = true

  cluster_addons = {
    # aws-guardduty-agent = {
    #   most_recent = true
    # }
    aws-ebs-csi-driver = {
      most_recent = true
    }
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    # vpc-cni = {
    #   most_recent    = true
    #   before_compute = true
    #   configuration_values = jsonencode({
    #     env = {
    #       # Reference docs https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
    #       ENABLE_PREFIX_DELEGATION = "true"
    #       WARM_PREFIX_TARGET       = "1"
    #     }
    #   })
    # }
  }
  eks_managed_node_group_defaults = {
    disk_size      = 100
    instance_types = [local.default_instance_type]
  }

  eks_managed_node_groups = {
    general = {
      desired_size = 1
      min_size     = 1
      max_size     = 20

      labels = {
        role = "general"
      }

      # ami_type       = "AL2_ARM_64"
      # instance_types         = ["t3.xlarge", "t3.large"]
      capacity_type          = "ON_DEMAND"
      create_launch_template = false
      launch_template_name   = ""

      metadata_options = {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 2
        instance_metadata_tags      = "disabled"
      }

      # block_device_mappings = {
      #   xvdb = {
      #     device_name = "/dev/xvdb"
      #     ebs = {
      #       volume_size = 50
      #       volume_type = "gp3"
      #       iops        = 3000
      #       encrypted   = true
      #       # kms_key_id            = aws_kms_key.eks.arn
      #       delete_on_termination = true
      #     }
      #   }
      # }
    }
  }

  manage_aws_auth_configmap = true
  aws_auth_roles = [
    {
      rolearn  = module.eks_admins_iam_role.iam_role_arn
      username = module.eks_admins_iam_role.iam_role_name
      groups   = ["system:masters"]
    },
  ]

  node_security_group_additional_rules = {
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 9443
      to_port                       = 9443
      source_cluster_security_group = true
      description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
    }
    # ingress_allow_access_mysql = {
    #   type                          = "ingress"
    #   protocol                      = "tcp"
    #   from_port                     = 3306
    #   to_port                       = 3306
    #   security_group_id             = local.db_sg_id
    #   source_cluster_security_group = true
    #   description                   = "Allow access from mysql"
    # }
  }

  tags = {
    Environment = local.prefix
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  # token                  = data.aws_eks_cluster_auth.default.token

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_id]
    command     = "aws"
  }
}