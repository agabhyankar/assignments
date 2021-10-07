terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  credentials = file(var.creds_file)
  project = var.project
  region  = var.region
  zone    = var.zone
}


