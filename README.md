<div align="center">
  <h1 style="color: red;">Advanced DevOps project :globe_with_meridians::hammer_and_wrench:</h1>
</div> 


# 🚀 DevOps Project

Welcome to my DevOps project repository! this project automates AWS service and K8S resources provisioning via Terraform, Jenkins orchestrates three pipelines, the first is to automate the Provisioning of the infrastructure, and the second is to dockerize the Node.js app and push it to private repo ECR and then trigger the third pipeline (CD pipeline), third pipeline to update the image name in Helm chart values.yaml. The Node.js app effortlessly communicates with RDS and the APP stores the IP when you hit a certain endpoint and lists all the IPs stored when you hit  another endpoint, ArgoCD adds the final touch, enabling continuous deployment with GitOps principles.

##  Project Design

![devops-task](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/3948183e-9730-411a-b9a3-0b0ebc302fc3)

## :gear: Tools & Operators :
- Docker
- Terraform
- K8S (AWS EKS)
- RDS
- route53
- Jenkins
- Argocd
- Helm chart
- cert-manager
- nginx ingress

  

#### Prerequisites
- owned domain name
- AWS CLI configured with necessary permissions.
- Terraform, kubectl, and docker CLI tools should be installed 
- Jenkins and Helm installed locally
- basic knowledge about nodejs and the tools used in this project
### explanation
#### In the following lines I want to discuss each service and operator we are creating with Terraform
- EKS            --> a platform to deploy our application on
- ECR            --> a private repo to store, push, and pull the docker images
- RDS            --> the Database which we use with nodejs APP to store and display the IPs stored in
- route53        --> Create a new CNAME record to point on the ingress URL to pass the let's encrypt challenge
- nginx ingress  --> just an ingress controller!
- cert-manager   --> k8s operators to issue trusted TLS certificate
- argoCD         --> another operator for implementing the GitOps concept
- OIDC           --> apply the IRSA concept to grant the service account the permissions that it needs only

### Steps
### 1. Provision Infrastructure using Terraform
- start building your Infrastructure using terraform --> (EKS, ECR, RDS, and route53)
- create k8s oprators with terraform --> (ingress, cert-manager and argocd)
- you can find all the terraform files under `terraform` folder
- display the required attribute using output block in terraform --> (RDS endpoint, ECR URL)
### 2. create your Application
- start creating your app, in my case, I used nodejs(Express)
- the application should expose two APIs endpoints
- The first one `<your-host>.com/client-ip`, this saves your ip in the RDS
- The second one  `<your-host>.com/client-ip/list`, this displays the list of IPs stored in the database
### 3. Dockerize the application
- create a docker file for your application
- create a docker container manually to make sure that everything works well ---> only  for testing
### 4. k8s manifest files
- create required k8s manifest files for your application
- note: don't forget to create a secret for your ECR to make your cluster authorized to pull images from the ECR registry
- note: in the cluster autoscaler manifest file, you  should modify the following things:
    - the arn URL of the role for the service account
    - modify the cluster name with your real cluster name
    - modify the cluster version with your real cluster version
### 5. Helm chart
- create your Helm chart for packaging your manifest files using the following command
    - ```bash helm create <your_helm_chart_name>```
- update the values.yaml with the appropriate values
### 6. automate infra using Jenkins
- now we have to create a parameterized pipeline for automating the infrastructure creation
- in my case, I used two options as a parameters --> (apply & destroy)
- ![parm-terr](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/50021f0b-e792-48ee-861a-16b3a75594bd)
- Jenkins file existed under `jenkins_files` directory
- note: don't forget to add your aws credential --> aws access and secret access key
  ![terraform-jenkins](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/53bbe809-a02b-4b1a-9eba-e370eea9395e)

### 7. Automate build, push, and trigger the CD pipeline
- now we need to create a CI pipeline
- CI pipeline will pull the repo
- dockerize the nodejs app
- push the image to the ECR
- trigger the CD pipeline and send the image version as a parameter to the CD pipeline
- Jenkins file existed under `jenkins_files` directory
![ci-pipe](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/35ed99d9-06b0-4982-8991-18fa52972326)

### 8. CD pipeline
- now we should create the CD pipeline
- CD pipeline will clone the repo
- update the HELM chart values.yaml with the image name that we get as a parameter from the CI pipeline
- push the changes to the same repo again
- - Jenkins file existed under `jenkins_files` directory
  ![CD-PIPE](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/a0d252ab-c30c-43b1-9d7a-2d26e7a61887)

### 9. argocd and continuous deployment
- in this step we need to connect or sync argocd with the repo
- note: to sync the repo with argocd, we have three ways
    - 1- using the command line via argocd CLI tool
    - ```bash
      argocd repo add REPO_NAME --type REPO_TYPE --url REPO_URL --username REPO_USERNAME --password REPO_PASSWORD
      argocd app create APP_NAME --repo REPO_URL --path PATH_TO_APP --dest-server DEST_SERVER --dest-namespace DEST_NAMESPACE
       ```
    - 2- using a declarative way
    - 3- using the UI which is the way I used in this project
- add your repo to argocd repos
![Capture](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/e3100651-732f-4152-bc89-9b0016d3ab1d)
- create application 
![Capture2](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/c6cf61f2-2b49-4d38-b347-3270e832ad8a)
![Capture3](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/00d42ebe-66df-420b-a0ae-2061d9d42307)


#### Now let's try the app
![yalla](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/e37df0f3-44c9-454d-9bb8-f5d60c69fb94)
![yallla2](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/529d1616-9148-4c35-9c7f-fb175a5c8ad2)
#### Here you can look at the lock of the certificate
![yallla22](https://github.com/AbdelrhmanAli123/advanced-devops-task/assets/133269614/b1687a26-9740-4fa7-8d91-46bf0d2712ee)


## 🎉 Conclusion

This project demonstrates a complete DevOps pipeline for provisioning infrastructure, building and pushing Docker images and deploying applications on AWS EKS. Feel free to explore and adapt the code to fit your specific requirements.
