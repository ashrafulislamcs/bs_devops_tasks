resource "kubernetes_namespace" "flarie_service" {
  metadata {
    name = local.namespace
  }
}

# resource "kubernetes_namespace" "datadog" {
#   metadata {
#     name = "datadog"
#   }
# }

# resource "kubernetes_namespace" "prometheus" {
#   metadata {
#     name = "prometheus"
#   }
# }