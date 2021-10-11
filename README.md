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

### Recommendation and changes
  * IAC
    * Implement remote state with bucket
    * Output file should not show sensitive details like credentials. Also it should not show values from variables but it should show data from resources.
    * Avoid hardcoding and use variables
    * Should have a single copy of code for multiple env.
    * Modularize code to reuse it.
    * Credential files should be injected on the fly.
  * Scalability
    * Horizontal Auto Scaling for PODs based on required matrix
    * Horizontal Auto Scaling for Nodes based on resource consumption
    * Use slim container images to ease autoscaling
  * Security & Hardening
    * Private Kubernetes cluster - (Submitted code for same)
    * Restrict accesibility of control plane
    * Private Cloud SQL (Submitted code for same)
    * Connect application using Cloud SQL proxy
    * Hardened OS / COS_Container (Google provided)
    * Do not open any port for all(0.0.0.0/0)
    * Restrict access of wp admin page
    * Use SSL certificate to enable https connection
    * Configure WAF as per the OWASP standards
    * Use cloud CDN for DDOS prevention
    * POD security policy needs to be configured
    * Proper IAM roles needs to be configured to implement least privileges
    * Use multiple service account to implement separation of duties
    * Use namespaces for kubernetes deployment
    * Container images should be scanned for vulnerabilities
    * Wherever possible cook your own images by having a docker file and alpine is the recommended base image
    * Binary authorization should be used
  * Compliances
    * Data sovereignity and Data residency eg. GDPR (Cloud DLP API to be used to detect PII)
    * If payment gateway is used then PCI DSS compliance required
    * If application is used for helthcare related services then it should be HIPPA compliance
    * Cloud Security Center can be used to monitor compliance matrix
  * Other
    * What compliances are you aware of for this type of infrastructure? Pick one, How would you apply that here? Show code if possible
      * Compliance List is provided. GDPR related implementation can be done by providing GUI for data subject to approve usage of PII and to be processed. Necessory infrastructure needs to be deployed in Europe region. 
    * What kind of scalability can be implemented here? Pick one, How would you implement it? Show code if possible
      * Scalablitiy related details are already mentioned in above section of Scalability. Example code is checked-in for Node auto scaling in test_3_gke.tf.
    * What different security and hardening options are you aware of? Pick one, How would you approach it in this environment? Show code if possible
      * Refer above section for Securiy and hardening. Example code is also checked-in in test_1_vpc.tf, test_2_db.tf, test_3_gke.tf. 
  * If you plan to do more but not as code (items relevant to Other Section), feel free to update Readme with further plan of action.  
