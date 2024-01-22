<div align="center">
  <h1 style="color: red;">Advanced DevOps project :globe_with_meridians::hammer_and_wrench:</h1>
</div> 


# 🚀 DevOps Project

Welcome to my DevOps project repository! this project automates AWS service provisioning via Terraform, Jenkins orchestrates three pipelines, the first is to automate the Provisioning of the infrastructure, and the second is to dockerize the Node.js app and push it to private repo ECR and then trigger the third pipeline (CD pipeline), third pipeline to update the image name in Helm chart values.yaml. The Node.js app effortlessly communicates with RDS and the APP stores the IP when you hit certain endpoint and list all the IPs stored when you hit  another endpoint, ArgoCD adds the final touch, enabling continuous deployment with GitOps principles.

##  Project Design

![devops-task](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/3948183e-9730-411a-b9a3-0b0ebc302fc3)

## :gear: Tools & Oprators :
- Docker
- Terraform
- K8S (AWS EKS)
- RDS
- route53
- secret manager
- Jenkins
- Argocd
- Helm chart
- cert-manager
- nginx ingress

  
### 1. Provision Infrastructure

#### Prerequisites
- owned domain name
- AWS CLI configured with necessary permissions.
- Terraform, kubectl, and docker CLI tools should be installed installed
- Helm installed locally
- basic knowladge about nodejs and the tools used in this project
### explaintion
#### in the following lines i wanna discuss about each service and oprator we are creating with terraform
- EKS            --> a platform to deploy our application on
- ECR            --> a private repo to store, push and pull the docker images
- RDS            --> the Database which we use it with nodejs APP to store and display the IPs stored in
- secret manager --> used to store RDS credentials
- route53        --> create a new CNAME recored to point on the ingress url to pass the let's encrypt challenge
- nginx ingress  --> just an ingress controller !
- cert-manager   --> k8s opratort to issue trusted TLS certificate
- argoCD         --> another oprator for implementing the GitOps concept
- OIDC           --> apply the IRSA concept to grant the service account the permsision that it needs only
  
### Steps
### 1. Create the infrastructure using Terraform
- start building your infra using terraform --> (EKS, ECR, RDS, secret manager and route53)
- create k8s oprators with terraform --> (ingress, cert-manager and argocd)
- you can find all the terraform files under `terraform` folder
- display the required attribute using output block in terraform --> (RDS endpoint, ECR URL)
### 2. create your Application
- start creating your app, in my case i used nodejs(Express)
- the application should expose two APIs endpoints
- first one "<your-host>.com/client-ip", this saves your ip in the RDS
- second one  "<your-host>.com/client-ip/list", this display the list of IPs stored in the database
### 3. Dockerize the application
- create docker file for your application
- create docker container manually to make sure that everything works well ---> only  for testing
### 4. k8s manifest files
- create required k8s manifest files for your application
- note: don't forget to create secret for your ECR to make your cluster authrize to pull images from ECR registry
- note: in the cluster autoscaler manifest file, you  should modify the following things:
    - the arn url of the role for service account
    - modify the cluster name with your real cluster name
    - modify the cluster version with your real cluster version
### 5. Helm chart
- create your Helm chart for packaging your manifest files using the following command
    - ```bash helm create <your_helm_chart_name>```
- update the values.yaml with the approprite values
### 6. automate infra using jenkins
- now we have to create parmatrized pipeline for automating the infrastructure creation
- in my case i used two option as a parameters --> (apply & destroy)
- ![parm-terr](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/50021f0b-e792-48ee-861a-16b3a75594bd)
- jenkins file existed under `jenkins_files` directory
- note: don't forget to add your aws credential --> aws access and secret access key
  ![terraform-jenkins](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/53bbe809-a02b-4b1a-9eba-e370eea9395e)

### 7. automate build, push and trigeer the CD pipeline
- now we need to create CI pipeline
- CI pipeline will checkout the repo
- dockerize the nodejs app
- push the image to the ECR
- trigger the CD pipeline and send the image version as a paramter to the CD pipeline
- jenkins file existed under `jenkins_files` directory
![ci-pipe](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/35ed99d9-06b0-4982-8991-18fa52972326)

### 8. CD pipeline
- now we should create the CD pipeline
- CD pipeline will checkout the repo
- update the HELM chart values.yaml with the image name that we get as paramter from the CI pipeline
- push the changes to the same repo again
- - jenkins file existed under `jenkins_files` directory
  ![CD-PIPE](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/a0d252ab-c30c-43b1-9d7a-2d26e7a61887)

### 9. argocd and continus deployment
- in this step we need to connect or sync argocd with the repo
- note: to sync the repo with argocd, we have three ways
    - 1- using command line via argocd CLI tool
    - ```bash
      argocd repo add REPO_NAME --type REPO_TYPE --url REPO_URL --username REPO_USERNAME --password REPO_PASSWORD
      argocd app create APP_NAME --repo REPO_URL --path PATH_TO_APP --dest-server DEST_SERVER --dest-namespace DEST_NAMESPACE
       ```
    - 2- using declrative way
    - 3- using the UI which is this the way i used in this project
- add your repo to argocd repos
![Capture](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/e3100651-732f-4152-bc89-9b0016d3ab1d)
- create application 
![Capture2](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/c6cf61f2-2b49-4d38-b347-3270e832ad8a)
![Capture3](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/00d42ebe-66df-420b-a0ae-2061d9d42307)


#### now let's try the app
![yalla](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/e37df0f3-44c9-454d-9bb8-f5d60c69fb94)
![yallla2](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/529d1616-9148-4c35-9c7f-fb175a5c8ad2)
#### here you can look at the lock of the certificate
![yallla22](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/b1687a26-9740-4fa7-8d91-46bf0d2712ee)


## 🎉 Conclusion

This project demonstrates a complete DevOps pipeline for provisioning infrastructure, building and pushing Docker images, and deploying applications on AWS EKS. Feel free to explore and adapt the code to fit your specific requirements.
