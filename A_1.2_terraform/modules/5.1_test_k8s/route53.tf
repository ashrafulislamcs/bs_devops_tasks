##########
# Route53
##########

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "2.11.0"

  zone_id = data.aws_route53_zone.this.zone_id

  records = [
    {
      name = local.subdomain
      type = "A"
      alias = {
        evaluate_target_health = true
        name                   = module.global_accelerator.dns_name
        zone_id                = module.global_accelerator.hosted_zone_id
      }
    },
  ]
}