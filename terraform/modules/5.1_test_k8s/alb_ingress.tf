resource "kubectl_manifest" "flarie_alb" {
  yaml_body = <<-EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: flarie-ingress
  namespace: ${local.namespace}
  annotations:
    nginx.ingress.kubernetes.io/proxy-buffer-size: "16k"
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/proxy-body-size: 100m
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
    alb.ingress.kubernetes.io/certificate-arn: ${local.alb_certificate_arn}
    alb.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80}, {"HTTPS":443}]'
    alb.ingress.kubernetes.io/ssl-redirect: '443'
    alb.ingress.kubernetes.io/healthcheck-path: '/rest/account-service/v1/health'
    alb.ingress.kubernetes.io/healthcheck-port: '80'
    alb.ingress.kubernetes.io/healthcheck-protocol: HTTP
    alb.ingress.kubernetes.io/success-codes: 200-300
    alb.ingress.kubernetes.io/healthy-threshold-count: '2'
    alb.ingress.kubernetes.io/unhealthy-threshold-count: '3'
    alb.ingress.kubernetes.io/load-balancer-attributes: access_logs.s3.enabled=true,access_logs.s3.bucket=${local.prefix}-flarie-log,access_logs.s3.prefix=alb-access-log
    alb.ingress.kubernetes.io/actions.public-test: |
      {
        "Type":"forward",
        "ForwardConfig":{
            "TargetGroups":[
              {
                  "ServiceName":"test-service-service",
                  "ServicePort":"80"
              }
            ]
        }
      }
    alb.ingress.kubernetes.io/actions.redirect-to-game: |
      {
        "type":"redirect",
        "redirectConfig":{
            "host":"${local.backend_host}",
            "path":"/rest/link-service/v1/links/#{path}",
            "query":"#{query}",
            "port":"443",
            "protocol":"HTTPS",
            "statusCode":"HTTP_302"
        }
      }

spec:
  ingressClassName: "alb"
  rules:
    - host: ${local.backend_host}
      http:
        paths:
          - path: /api/hello
            pathType: Prefix
            backend:
              service:
                name: test-service-service
                port:
                  number: 80
          - path: /api/health
            pathType: Prefix
            backend:
              service:
                name: test-service-service
                port:
                  number: 80        
      
EOF
}