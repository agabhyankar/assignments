resource "google_compute_router" "edu_router" {
  name    = "edu-router"
  network = module.vpc.network_self_link
}


module "cloud-nat" {
  depends_on = [module.vpc]
  source     = "terraform-google-modules/cloud-nat/google"
  #version    = "~> 1.2"
  project_id = var.project_id
  region     = var.region
  router     = google_compute_router.edu_router.name
  nat_ips    = google_compute_address.ip.*.self_link
}

resource "google_compute_address" "ip" {
  name  = format("${var.ip_name}%03d", count.index + 1)
  count = var.ip_count

  lifecycle {
    prevent_destroy = false
  }
}







