provider "google" {
  region  = var.region
  project = var.project_id
  #  credentials = GOOGLE_CREDENTIALS
}

data "google_client_config" "default" {}

data "google_container_cluster" "cluster0" {
  name     = var.cluster_name
  location = var.gke_zone
}

provider "helm" {
  kubernetes {
    host                   = data.google_container_cluster.cluster0.endpoint
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.google_container_cluster.cluster0.master_auth.0.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = data.google_container_cluster.cluster0.endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.cluster0.master_auth.0.cluster_ca_certificate)
}

terraform {
  required_version = ">= 0.15"
  # backend "gcs" {
  #   bucket  = "bucket-name"
  #   prefix  = "terraform/gcp"
  # }
}

