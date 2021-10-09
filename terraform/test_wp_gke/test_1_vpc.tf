// Creating VPC and subnet
resource "google_compute_network" "testvpc" {
  name = var.vpc  
  auto_create_subnetworks = "false"
}

// Creating Subnet with secondary IP ranges to be used with GKE pods and services
resource "google_compute_subnetwork" "test-subnetwork" {
  name = var.subnet
  ip_cidr_range = "10.10.10.0/24"
  region = var.region
  network = google_compute_network.testvpc.name

  secondary_ip_range  = [
    {
        range_name    = "services"
        ip_cidr_range = "10.10.11.0/24"
    },
    {
        range_name    = "pods"
        ip_cidr_range = "10.1.0.0/20"
    }
  ]

  private_ip_google_access = true
}

// Creating peering for Cloud SQL
resource "google_compute_global_address" "private-ip-peering" {
  name          = "google-managed-services-testvpc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = google_compute_network.testvpc.id
}

resource "google_service_networking_connection" "private-vpc-connection" {
  network = google_compute_network.testvpc.id
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.private-ip-peering.name
  ]
}
