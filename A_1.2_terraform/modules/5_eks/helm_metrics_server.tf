resource "helm_release" "metrics-server" {
  name = "${local.prefix}-ms"

  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  # version    = "3.8.3"

  # values = [
  #   "${file("../../flarie-helm-infrastructure/values/metics-server-values.yaml")}"
  # ]

  # depends_on = [helm_release.kubernetes_dashboard, kubernetes_namespace.kubernetes_dashboard]

  set {
    name  = "replicas"
    value = 1
  }
  wait = true
}