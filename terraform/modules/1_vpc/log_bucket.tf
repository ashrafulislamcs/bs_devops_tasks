data "aws_canonical_user_id" "current" {}
data "aws_cloudfront_log_delivery_canonical_user_id" "cloudfront" {}

module "log_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.6.0"

  bucket        = "${local.prefix}-flarie-log"
  acl           = "log-delivery-write"
  force_destroy = true

  request_payer            = "BucketOwner"
  object_ownership         = "ObjectWriter"
  control_object_ownership = true

  attach_elb_log_delivery_policy        = true
  attach_lb_log_delivery_policy         = true
  attach_deny_insecure_transport_policy = true
  attach_require_latest_tls_policy      = true
}

module "cloudfront_log_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.6.0"

  bucket                   = "${local.prefix}-cloudfront-log-v2"
  request_payer            = "BucketOwner"
  object_ownership         = "ObjectWriter"
  control_object_ownership = true

  grant = [{
    type       = "CanonicalUser"
    permission = "FULL_CONTROL"
    id         = data.aws_canonical_user_id.current.id
    }, {
    type       = "CanonicalUser"
    permission = "FULL_CONTROL"
    id         = data.aws_cloudfront_log_delivery_canonical_user_id.cloudfront.id # Ref. https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/AccessLogs.html
    }
  ]

  owner = {
    id = data.aws_canonical_user_id.current.id
  }

  force_destroy = true
}