resource "helm_release" "ingress" {
  depends_on  = [kubernetes_namespace.namespace]
  name        = "ingress"
  repository  = "https://kubernetes.github.io/ingress-nginx"
  chart       = "ingress-nginx"
  version     = "4.5.2"
  namespace   = var.namespaces[0]
  timeout     = 800  # Set a higher timeout value in seconds
}
