//Outputs
output "wp_service_url" {
  value = kubernetes_service.test_wpservice.status[0].load_balancer[0].ingress[0].ip
  depends_on = [
    kubernetes_service.test_wpservice
  ]
}

output "db_host" {
  value = google_sql_database_instance.testwpdbvm.ip_address.0.ip_address

  depends_on = [
    google_sql_database_instance.testwpdbvm
  ]
}

output "database_name" {
  value = var.wpdb

  depends_on = [
    google_sql_database_instance.testwpdbvm
  ]
}

output "db_user_name" {
  value = var.wpdb_user

  depends_on = [
    google_sql_database_instance.testwpdbvm
  ]
}
