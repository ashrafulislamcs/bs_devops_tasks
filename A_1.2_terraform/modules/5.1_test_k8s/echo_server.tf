resource "kubectl_manifest" "flarie_echo" {
  yaml_body = <<-EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: landing
  namespace: ${local.namespace}
spec:
  selector:
    matchLabels:
      app: landing
  replicas: 1
  template:
    metadata:
      labels:
        app: landing
    spec:
      containers:
      - image: nginx
        name: landing
        ports:
        - containerPort: 80
EOF
}
resource "kubectl_manifest" "flarie_echo_svc" {
  yaml_body = <<-EOF
apiVersion: v1
kind: Service
metadata:
  name: landing
  namespace: ${local.namespace}
spec:
  ports:
  - port: 80
    protocol: TCP
  type: ClusterIP
  selector:
    app: landing
EOF
}
