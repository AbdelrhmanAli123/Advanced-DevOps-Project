resource "kubernetes_namespace" "namespace" {
  for_each = toset(var.namespaces)
  metadata {
    name = each.value
  }

}

