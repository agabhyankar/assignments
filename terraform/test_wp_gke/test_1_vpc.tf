// Creating VPC and subnet
resource "google_compute_network" "testvpc" {
  name = var.vpc
  auto_create_subnetworks = "true"
}
