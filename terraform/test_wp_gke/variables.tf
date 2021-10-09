variable "creds_file" { }
variable "project" { }
variable "region" { }
variable "zone" { }

// VPC, subnet and firewall
variable "vpc" { }
variable "subnet" { }

// Wordpress specific details
variable "wpdbvm" { }
variable "wpdb" { }
variable "wpdb_user" { }
variable "wpdb_userpass" { }

// Cluster details
variable "gke" {}
variable "gkenodepool" {}
variable "min_node_count" {}
variable "max_node_count" {}

// Deployment Details
variable "wpdep" {}
variable "wppod" {}

// Variables for gke
variable "gke_master_ipv4_cidr_block" {
  type    = string
  default = "172.23.0.0/28"
}

variable "authorized_source_ranges" {
  type        = list(string)
  description = "Addresses or CIDR blocks which are allowed to connect to GKE API Server."
}
