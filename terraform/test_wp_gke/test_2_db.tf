resource "random_uuid" "db_instance_suffix" { }

//Configuring SQL Database instance
resource "google_sql_database_instance" "testwpdbvm" {
  name                = "${var.wpdbvm}${random_uuid.db_instance_suffix.result}"
  database_version    = "MYSQL_8_0"
  region              = var.region
  deletion_protection = "false"

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled = true
      private_network     = google_compute_network.testvpc.id
    }
  }
  
  depends_on = [
    google_service_networking_connection.private-vpc-connection
  ]


}

// Get wordpress password secret from secret manager
data "google_secret_manager_secret_version" "wordpress-admin-user-password" {
  secret = "wordpress-admin-user-password"
}

//Creating SQL Database
resource "google_sql_database" "testwpdb" {
  name     = var.wpdb
  instance = google_sql_database_instance.testwpdbvm.name

  depends_on = [
    google_sql_database_instance.testwpdbvm
  ]
}

//Creating SQL Database User
resource "google_sql_user" "testwpdbuser" {
  name     = var.wpdb_user
  instance = google_sql_database_instance.testwpdbvm.name
  password = data.google_secret_manager_secret_version.wordpress-admin-user-password.secret_data

  depends_on = [
    google_sql_database_instance.testwpdbvm
  ]
}
