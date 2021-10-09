//Creating LoadBalancer Service
resource "kubernetes_service" "test_wpservice" {
  metadata {
    name   = "wp-svc"
    labels = {
      env     = "Demo"
    }
  }

  spec {
    type     = "LoadBalancer"
    selector = {
      pod = kubernetes_deployment.testwp_dep.spec.0.selector.0.match_labels.pod
    }

    port {
      name = "wp-port"
      port = 80
      target_port = 80
    }
  }

  depends_on = [
    kubernetes_deployment.testwp_dep,
  ]
}
