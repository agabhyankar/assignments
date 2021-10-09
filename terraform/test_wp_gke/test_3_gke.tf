//Creating Container Cluster
resource "google_container_cluster" "testgke_cluster" {
  name                     = var.gke
  description              = var.gke
  project                  = var.project
  location                 = var.region
  network                  = google_compute_network.testvpc.name
  subnetwork		   = google_compute_subnetwork.test-subnetwork.name
  remove_default_node_pool = true
  initial_node_count       = 1

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.gke_master_ipv4_cidr_block
  }
  
  master_authorized_networks_config {
    dynamic "cidr_blocks" {
        for_each = var.authorized_source_ranges
        content {
            cidr_block = cidr_blocks.value
        }
    }
   }

  # Configuration of cluster IP allocation for VPC-native clusters
  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  # Configuration options for the Release channel feature, which provide more control over automatic upgrades of your GKE clusters.
  release_channel {
    channel = "REGULAR"
  }


}

//Creating Node Pool For Container Cluster
resource "google_container_node_pool" "testgke_nodepool" {
  name       = var.gkenodepool
  project    = var.project
  location   = var.region
  cluster    = google_container_cluster.testgke_cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-micro"
  }

  autoscaling {
		min_node_count 	= var.min_node_count
		max_node_count 	= var.max_node_count
  }

  depends_on = [
    google_container_cluster.testgke_cluster
  ]
}
