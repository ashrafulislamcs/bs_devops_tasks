# resource "helm_release" "test" {
#   name      = "test-service"
#   chart     = "../../flarie-helm-infrastructure/"
#   namespace = local.namespace

#   values = [
#     "${file("../../flarie-helm-infrastructure/values/${local.namespace}/test-service.yaml")}"
#   ]
# }