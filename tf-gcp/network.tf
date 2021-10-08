module "vpc" {
  source = "terraform-google-modules/network/google"
  #version = "~> 3.0"

  project_id   = var.project_id
  network_name = var.network_name
  routing_mode = "REGIONAL"

  subnets = [
    {
      subnet_name   = var.subnet10
      subnet_ip     = "10.10.10.0/24"
      subnet_region = var.region
    },
    {
      subnet_name   = var.subnet20
      subnet_ip     = "10.10.20.0/24"
      subnet_region = var.region
    },
    {
      subnet_name   = var.subnet30
      subnet_ip     = "10.10.30.0/24"
      subnet_region = var.region
    }
  ]

  secondary_ranges = {
    (var.subnet10) = [
      {
        range_name    = "${var.subnet10}-pods"
        ip_cidr_range = "192.168.10.0/24"
      },
      {
        range_name    = "${var.subnet10}-services"
        ip_cidr_range = "192.168.112.0/20"
      },
      {
        range_name    = "${var.subnet10}-pod"
        ip_cidr_range = "192.168.128.0/20"
      },
    ]

    (var.subnet20) = [
      {
        range_name    = "${var.subnet20}-secondary"
        ip_cidr_range = "192.168.20.0/24"
      }
    ]

    (var.subnet30) = [
      {
        range_name    = "${var.subnet30}-secondary"
        ip_cidr_range = "192.168.30.0/24"
      }
    ]

  }

  routes = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    }
  ]
}
