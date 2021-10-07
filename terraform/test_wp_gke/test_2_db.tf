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

      authorized_networks {
        name  = "sqlnet"
        value = "0.0.0.0/0"
      }
    }
  }
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
  password = var.wpdb_userpass

  depends_on = [
    google_sql_database_instance.testwpdbvm
  ]
}
