# Google Kubernetes Engine (GKE)

Terraform code to manage Google Kubernetes Engine (GKE)

## Overview

Specificities:
+ No Highly availability: there are masters and nodes in 1 zone, but could be easily used with HA
+ Secured from outside: nodes have no external IPs, Internet access is granted via NAT router
+ L7 load balancing feature disabled: no automatic creation of load balancer resource on GCP when creating an ingress in K8S cluster. We want one public access through ingress-controller only.
+ All recourses

## Code structure

```
.
├── README.md
├── tf-gcp
│   ├── cloudnat.tf
│   ├── gke.tf
│   ├── main.tf
│   ├── network.tf
│   └── variables.tf
└── tf-gke
    ├── main.tf
    ├── variables.tf
    ├── wp-values.yml
    └── wp.tf
```

## WordPress

Installed with as Helm release [bitnami chart.](https://github.com/bitnami/charts/tree/master/bitnami/wordpress/)
Configuration with [wp-values.yml](./tf-gke/wp-values.yml).
Insalls 2 replicas of WP + hpa and pdb. Published as loadbalancer(lb ip will be in outputs URL.) MariaDB installs also as part of chart with PVC.
**IMPORTANT** before apply update `wordpressPassword` in [wp-values.yml](./tf-gke/wp-values.yml). To create admin password.

## Usage

Before start you need:
+ update `wordpressPassword` in [wp-values.yml](./tf-gke/wp-values.yml). To create admin password.
+ update `project_id` [variables.tf](./tf-gcp/variables.tf) specify GCP project.
+ (Optional) specify backend GCS bucket to store state remotely.

```sh
### create GCP infra
cd tf-gcp && terraform init && terraform apply
### destroy GCP infra
cd tf-gcp && terraform init && terraform destroy
```

```sh
### setup k8s resources(wordpress)
cd tf-gke && terraform init && terraform apply
### destroy GCP infra
cd tf-gke && terraform init && terraform destroy
```

## Security

Since cluster already private, suggest to use cloudflare, it will allow protect non-prod env's + WAF
