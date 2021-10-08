variable "project_id" {
  default = ""
}

variable "region" {
  default = "europe-west3"
}

variable "region_zones" {
  type        = list(any)
  default     = ["europe-west3-a", "europe-west3-b", "europe-west3-c"]
  description = "Google zone to use in a region"
}

variable "gke_zone" {
  default     = "europe-west3-a"
  description = "Google zone for GKE zonal cluster"
}

variable "router_name" {
  default     = "gke-edu-test"
  description = "CloudNAT router name"
}

variable "ip_count" {
  default     = 3
  description = "Number of IPs to allocate"
}

variable "ip_name" {
  default     = "cloudnat-eduip"
  description = "Name will be shown on google"
}

variable "network_name" {
  default = "gke-vpc"
}

variable "service_account" {
  default = "gke-svc@devops-ll-sandbox.iam.gserviceaccount.com"
}

variable "subnet10" {
  default = "gke-10"
}

variable "subnet20" {
  default = "gke-20"
}

variable "subnet30" {
  default = "gke-30"
}

variable "cluster_name" {
  default = "gke-europe-west3"
}
