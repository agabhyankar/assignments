resource "helm_release" "wp_0" {
  depends_on       = [module.gke]
  name             = "wp"
  namespace        = "wp"
  create_namespace = true
  chart            = "wordpress"
  repository       = "https://charts.bitnami.com/bitnami"
  verify           = false
  version          = "12.1.19"
  wait             = true
  values           = [file("wp-values.yml")]
}

# Load Balancer output
data "kubernetes_service" "wp_0" {
  depends_on = [helm_release.wp_0] # Always triggers data refresh
  metadata {
    name      = "${helm_release.wp_0.name}-wordpress"
    namespace = helm_release.wp_0.namespace
  }
}

output "wordpress_loadbalancer_ip" {
  value = data.kubernetes_service.wp_0.load_balancer_ingress.0.ip
}
}
