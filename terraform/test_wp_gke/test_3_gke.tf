//Creating Container Cluster
resource "google_container_cluster" "testgke_cluster" {
  name                     = var.gke
  description              = var.gke
  project                  = var.project
  location                 = var.region
  network                  = google_compute_network.testvpc.name
  remove_default_node_pool = true
  initial_node_count       = 1
  cluster_autoscaling {
    enabled = true
    resource_limits {
      
      resource_type = "cpu"
      minimum = 1
      maximum = 2
    }
    resource_limits {
      resource_type = "memory"
      minimum = 1
      maximum = 2
    }
    
  }

}

//Creating Node Pool For Container Cluster
resource "google_container_node_pool" "testgke_nodepool" {
  name       = var.gkenodepool
  project    = var.project
  location   = var.region
  cluster    = google_container_cluster.testgke_cluster.name

  node_config {
    preemptible  = true
    machine_type = "e2-micro"
  }
    autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  depends_on = [
    google_container_cluster.testgke_cluster
  ]
}
