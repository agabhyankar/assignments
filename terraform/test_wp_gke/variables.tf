variable "creds_file" {
    type = string
    default = "cred.json"
 }
variable "project" {
    type = string
    default = "just-coda-328307"
 }
variable "region" {
    type = string
    default = "us-west1"
 }
variable "zone" { 
    type = string
    default = "us-west1-a"
}

// VPC, subnet and firewall
variable "vpc" { }

// Wordpress specific details
variable "wpdbvm" {
    type = string
    default = "wpdbvm"
 }
variable "wpdb" { 
    type = string
    default = "wpdb"
}
variable "wpdb_user" { 
    type = string
    default = "test"
}
variable "wpdb_userpass" {
    type = string
    default = "toor"
 }

// Cluster details
variable "gke" {
    type = string
    default = "gke"
}
variable "gkenodepool" {
    type = string
    default = "gkenodepool"
}

// Deployment Details
variable "wpdep" {
    type = string
    default = "wpdep"
}
variable "wppod" {
    type = string
    default = "wppod"  
}
