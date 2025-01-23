resource "helm_release" "nginx" {
  name       = "nginx"
  chart      = "nginx"
  namespace  = "default" # Create the namespace if it doesn't exist

  repository = "https://charts.bitnami.com/bitnami"
  version    = "15.0.0" # Specify the version of the chart

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "replicaCount"
    value = "2"
  }
}