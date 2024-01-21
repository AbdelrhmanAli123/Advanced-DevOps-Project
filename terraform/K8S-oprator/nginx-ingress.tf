resource "helm_release" "ingress" {
  depends_on  = [kubernetes_namespace.namespace]
  name        = "ingress"
  repository  = "https://kubernetes.github.io/ingress-nginx"
  chart       = "ingress-nginx"
  version     = "4.5.2"
  namespace   = var.namespaces[0]
  timeout     = 800  # Set a higher timeout value in seconds
}


data "kubernetes_service_v1" "ingress_ip" {
  depends_on = [ helm_release.ingress ]
  metadata {
    name = "ingress-ingress-nginx-controller"
    namespace = "ingress"
  }
  
}

// in my case the the route53 was already existed so this way i am using data block here !
data "aws_route53_zone" "defualt" {
  depends_on = [ data.kubernetes_service_v1.ingress_ip ]
  name = "balloapi.online"
}

resource "aws_route53_record" "ingress" {
  zone_id = data.aws_route53_zone.defualt.zone_id
  name    = "www.ingress.balloapi.online"
  type    = "CNAME"
  ttl     = 300
  records = [data.kubernetes_service_v1.ingress_ip.status.0.load_balancer.0.ingress.0.hostname]
}