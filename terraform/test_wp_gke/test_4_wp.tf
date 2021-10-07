data "google_client_config" "provider" {}


provider "kubernetes" {
  host  = "https://${google_container_cluster.testgke_cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  client_certificate = base64decode(
    google_container_cluster.testgke_cluster.master_auth[0].client_certificate
  )
  client_key = base64decode(
    google_container_cluster.testgke_cluster.master_auth[0].client_key
  )
  cluster_ca_certificate = base64decode(
    google_container_cluster.testgke_cluster.master_auth[0].cluster_ca_certificate,
  )
}

//WordPress Deployment
resource "kubernetes_deployment" "testwp_dep" {
  metadata {
    name   = var.wpdep
    labels = {
      env     = "Demo"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        pod     = var.wppod
        env     = "Demo"
      }
    }

    template {
      metadata {
        labels = {
          pod     = var.wppod
          env     = "Demo"
        }
      }

      spec {
        container {
          image = "wordpress"
          name  = "wp-container"

          env {
            name  = "WORDPRESS_DB_HOST"
            value = "${google_sql_database_instance.testwpdbvm.ip_address.0.ip_address}"
          }
          env {
            name  = "WORDPRESS_DB_USER"
            value = var.wpdb_user
          }
          env {
            name  = "WORDPRESS_DB_PASSWORD"
            value = var.wpdb_userpass
          }
          env{
            name  = "WORDPRESS_DB_NAME"
            value = var.wpdb
          }
          env{
            name  = "WORDPRESS_TABLE_PREFIX"
            value = "wp_"
          }

          port {
            container_port = 80
          }
        }
      }
    }
  }

  depends_on = [
    google_container_cluster.testgke_cluster,
    google_container_node_pool.testgke_nodepool,
  ]
}
