module "global_accelerator" {
  source  = "terraform-aws-modules/global-accelerator/aws"
  version = "2.2.0"

  name    = "${local.prefix}-alb-ga"
  enabled = true

  listeners = {
    listener_alb = {

      client_affinity = "SOURCE_IP"

      endpoint_group = {
        health_check_port             = 80
        health_check_protocol         = "HTTP"
        health_check_path             = "/"
        health_check_interval_seconds = 10
        health_check_timeout_seconds  = 5
        healthy_threshold_count       = 2
        unhealthy_threshold_count     = 2
        traffic_dial_percentage       = 100

        endpoint_configuration = [{
          client_ip_preservation_enabled = true
          endpoint_id                    = data.aws_lb.alb.arn
          weight                         = 100
        }]
      }
      port_override = [{
        endpoint_port = 8000
        listener_port = 80
        }, {
        endpoint_port = 8443
        listener_port = 443
      }]

      port_ranges = [
        {
          from_port = 80
          to_port   = 80
          }, {
          from_port = 443
          to_port   = 443
        }

      ]
      protocol = "TCP"
    }
  }
}