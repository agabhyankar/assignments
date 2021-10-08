module "gke" {
  depends_on         = [module.vpc, module.cloud-nat]
  source             = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  kubernetes_version = "latest"
  project_id         = var.project_id
  name               = var.cluster_name
  region             = var.region
  #zones                      = var.region_zones
  zones                      = [var.gke_zone]
  network                    = var.network_name
  subnetwork                 = var.subnet10
  ip_range_pods              = "${var.subnet10}-pod"
  ip_range_services          = "${var.subnet10}-services"
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  enable_private_endpoint    = false
  enable_private_nodes       = true
  network_policy             = false
  regional                   = false
  create_service_account     = true

  remove_default_node_pool = true
  #service_account    = "default"


  node_pools = [
    {
      name            = "main"
      machine_type    = "e2-medium"
      node_locations  = var.gke_zone
      min_count       = 0
      max_count       = 5
      local_ssd_count = 0
      disk_size_gb    = 10
      disk_type       = "pd-standard"
      image_type      = "cos_containerd"
      auto_repair     = true
      auto_upgrade    = true
      # service_account    = "default"
      preemptible        = false
      initial_node_count = 3
    },
    {
      name            = "secondary"
      machine_type    = "e2-medium"
      node_locations  = var.gke_zone
      min_count       = 0
      max_count       = 5
      local_ssd_count = 0
      disk_size_gb    = 10
      disk_type       = "pd-standard"
      image_type      = "cos_containerd"
      auto_repair     = true
      auto_upgrade    = true
      # service_account    = "default"
      preemptible        = true
      initial_node_count = 0
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
  cluster_resource_labels = {
    managed_by = "terraform"
  }

  node_pools_labels = {
    all = { managed_by = "terraform" }
  }

  node_pools_metadata = {
    all = {}
  }

  node_pools_taints = {
    all = []
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}
