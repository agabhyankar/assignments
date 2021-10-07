# General Assignments

## Prerequisites
* You need a github account to push your branch (submit your solution) to remote.
* You might need an AWS/Azure/GCP account. Create one if you do not own one already. You can use free-tier resources for this test.

## Updates
* Do not push to main or "dev" branch
* "dev" branch will have the assignments
* Create your own branch to push updates

## Terraform
### Assignment 1 - test_wp_gke_code (Deploy Wordpress on GCP GKE starting from setup of a VPC)
* Check the current terraform code and recommend as well as update the code to enhance adherence to standard practices
  * IAC
  * Scalability
  * Security & Hardening
  * Compliances
  * Other
    * What compliances are you aware of for this type of infrastructure? Pick one, How would you apply that here? Show code if possible
    * What kind of scalability can be implemented here? Pick one, How would you implement it? Show code if possible
    * What different security and hardening options are you aware of? Pick one, How would you approach it in this environment? Show code if possible
  * If you plan to do more but not as code (items relevant to Other Section), feel free to update Readme with further plan of action.  


---------------------------
Spent 6 hours on research and implementations of different terraform modules.
Scalabality:
For scalablity terraform  GKE modules are used. google_container_cluster and google_container_node_pool have attributes to add and enable scalability in the clusters and nodes.
Auto Scaling configurations were added which allows the cluster to scale when specific threshold are reached and manage the cluster accordingly. Container nodes also have scaling enable which sets minimum or maximum nodes available at a time
Replicas can modified on WP configuration module to maintain available pod replicas at a given time.
Security and Hardening:
Most of the communication is happening within the cluster and public endpoints are properly handled.
DB endpoint is also only accessible within the cluster and getting accessed through google API.
The VPC have auto_subnet_creation which takes care of the subnet creation on its own and creates subnets for all regions without manual intervention.
The DB passwords can be handled and not shown in the output where not required like normal script outputs.
Have restricted network access to the control plane and nodes
The code is divided into modules for different resources and are handled accordingly.
Variable names are proper and tells the purpose for which they will be used.
No credentials are hard coded  in the terraform code and are handled in separate file and used where required.

Using least privilege Google service accounts and handling user permissions properly.
Restrict access to cluster API discovery.
Restrict traffic among Pods with a network policy
Configure and use secrets management.
