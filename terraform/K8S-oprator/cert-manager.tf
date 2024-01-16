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

// you should install the cert-manager first 

resource "kubernetes_manifest" "cluster_issuer" {
  
  manifest = yamldecode(<<YAML

  
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: abdelrhmandev2000@gmail.com  # Replace with your email address
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: nginx

YAML
 )
  
  depends_on = [ helm_release.cert_manager, aws_route53_record.ingress ]
}


// as refrance only

# resource "kubernetes_manifest" "cert" {
  
#   manifest = yamldecode(<<YAML

  
# apiVersion: cert-manager.io/v1
# kind: Certificate
# metadata:
#    namespace: default
#    name: kubecert
# spec:
#    secretName: demo
#    issuerRef:
#      name: kubeissuer
#      kind: ClusterIssuer
#    commonName: devops.balloapi.online                      #CHANGE ME
#    dnsNames:
#    - devops.balloapi.online


# YAML
#  )
  
#   depends_on = [ helm_release.cert_manager, aws_route53_record.ingress ]
# }