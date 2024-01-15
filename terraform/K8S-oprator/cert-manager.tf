# Install cert-manager helm chart using terraform
resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.12.3"
  namespace  = var.namespaces[3]
set {
    name  = "installCRDs"
    value = "true"
  }
  depends_on = [
    kubernetes_namespace.namespace    
  ]
}