module "allow_eks_access_iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.34.0"

  name          = "${local.eks_name}-access"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:DescribeCluster",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ecr:*",
          "cloudtrail:LookupEvents",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "iam:CreateServiceLinkedRole",
        ]
        Condition = {
          StringEquals = {
            "iam:AWSServiceName" = [
              "replication.ecr.amazonaws.com",
            ]
          }
        }
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "codebuild:*",
          "codecommit:GetBranch",
          "codecommit:GetCommit",
          "codecommit:GetRepository",
          "codecommit:ListBranches",
          "codecommit:ListRepositories",
          "cloudwatch:GetMetricStatistics",
          "ec2:DescribeVpcs",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "elasticfilesystem:DescribeFileSystems",
          "events:DeleteRule",
          "events:DescribeRule",
          "events:DisableRule",
          "events:EnableRule",
          "events:ListTargetsByRule",
          "events:ListRuleNamesByTarget",
          "events:PutRule",
          "events:PutTargets",
          "events:RemoveTargets",
          "logs:GetLogEvents",
          "s3:GetBucketLocation",
          "s3:ListAllMyBuckets",
        ]
        Effect   = "Allow"
        Resource = "*"
        Sid      = "AWSServicesAccess"
      },
      {
        Action = [
          "logs:DeleteLogGroup",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:log-group:/aws/codebuild/*:log-stream:*"
        Sid      = "CWLDeleteLogGroupAccess"
      },
      {
        Action = [
          "ssm:PutParameter",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:ssm:*:*:parameter/CodeBuild/*"
        Sid      = "SSMParameterWriteAccess"
      },
      {
        Action = [
          "ssm:StartSession",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:ecs:*:*:task/*/*"
        Sid      = "SSMStartSessionAccess"
      },
      {
        Action = [
          "codestar-connections:CreateConnection",
          "codestar-connections:DeleteConnection",
          "codestar-connections:UpdateConnectionInstallation",
          "codestar-connections:TagResource",
          "codestar-connections:UntagResource",
          "codestar-connections:ListConnections",
          "codestar-connections:ListInstallationTargets",
          "codestar-connections:ListTagsForResource",
          "codestar-connections:GetConnection",
          "codestar-connections:GetIndividualAccessToken",
          "codestar-connections:GetInstallationUrl",
          "codestar-connections:PassConnection",
          "codestar-connections:StartOAuthHandshake",
          "codestar-connections:UseConnection",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:codestar-connections:*:*:connection/*"
        Sid      = "CodeStarConnectionsReadWriteAccess"
      },
      {
        Action = [
          "codestar-notifications:CreateNotificationRule",
          "codestar-notifications:DescribeNotificationRule",
          "codestar-notifications:UpdateNotificationRule",
          "codestar-notifications:DeleteNotificationRule",
          "codestar-notifications:Subscribe",
          "codestar-notifications:Unsubscribe",
        ]
        Condition = {
          StringLike = {
            "codestar-notifications:NotificationsForResource" = "arn:aws:codebuild:*"
          }
        }
        Effect   = "Allow"
        Resource = "*"
        Sid      = "CodeStarNotificationsReadWriteAccess"
      },
      {
        Action = [
          "codestar-notifications:ListNotificationRules",
          "codestar-notifications:ListEventTypes",
          "codestar-notifications:ListTargets",
          "codestar-notifications:ListTagsforResource",
        ]
        Effect   = "Allow"
        Resource = "*"
        Sid      = "CodeStarNotificationsListAccess"
      },
      {
        Action = [
          "sns:CreateTopic",
          "sns:SetTopicAttributes",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:sns:*:*:codestar-notifications*"
        Sid      = "CodeStarNotificationsSNSTopicCreateAccess"
      },
      {
        Action = [
          "sns:ListTopics",
          "sns:GetTopicAttributes",
        ]
        Effect   = "Allow"
        Resource = "*"
        Sid      = "SNSTopicListAccess"
      },
      {
        Action = [
          "chatbot:DescribeSlackChannelConfigurations",
          "chatbot:ListMicrosoftTeamsChannelConfigurations",
        ]
        Effect   = "Allow"
        Resource = "*"
        Sid      = "CodeStarNotificationsChatbotAccess"
      },
    ]
  })
}

module "eks_admins_iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.34.0"

  role_name         = "${local.eks_name}-admin"
  create_role       = true
  role_requires_mfa = false

  custom_role_policy_arns = [module.allow_eks_access_iam_policy.arn, "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess", "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"]

  # trusted_role_arns = [
  #   "arn:aws:iam::${module.vpc.vpc_owner_id}:root"
  # ]
  trusted_role_services = ["codebuild.amazonaws.com"]
}

module "user1_iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.34.0"


  name                          = "${local.prefix}-tfuser"
  create_iam_access_key         = false
  create_iam_user_login_profile = false

  force_destroy = true
}

module "allow_assume_eks_admins_iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.34.0"


  name          = "${local.prefix}-allow-assume-eks-admin-iam-role"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = module.eks_admins_iam_role.iam_role_arn
      },
    ]
  })
}

module "eks_admins_iam_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "5.34.0"


  name                              = "${local.eks_name}-admin"
  attach_iam_self_management_policy = false
  create_group                      = true
  group_users                       = [module.user1_iam_user.iam_user_name]
  custom_group_policy_arns          = [module.allow_assume_eks_admins_iam_policy.arn]
}