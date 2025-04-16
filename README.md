# devops-challenge

This repository contains an infrastructure-as-code and application setup to deploy a containerized microservice to AWS using ECS (Fargate), Load Balancer, and other required resources. The setup is divided into two parts:

---

## Repository Structure

### **Microservice Application**
Located in the `app/` directory:
- A Node.js Express-based API that returns the current server time and the visitor's IP address.
- Dockerized and pushed to **DockerHub**.
- Listens on port `3000`.

### **Terraform Infrastructure**
Located in the `terraform/` directory:
- Provisions a **VPC** with public/private subnets.
- Sets up an **ECS Cluster** with Fargate support.
- Configures a **Load Balancer** and **Target Group**.
- Deploys the service via ECS Fargate using a container image.
- Manages **IAM Roles**, **Security Groups**, and **Service Definitions**.

---

## Prerequisites

- Docker
- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- AWS credentials configured via `aws configure`, providing the access key, secret access key, and the default region.

## Steps to Run the Project

Step 1: Clone the repository -
```bash
git clone https://github.com/justmirr/devops-challenge.git
cd devops-challenge
```

### Running the application locally

Step 2: Run the commands given below in the `app/` directory - 
```bash
npm install --only=production
node index.js
```

Step 3: Go to `http://localhost:3000` to access the application page.

### Deploying the Infrastructure via Terraform

Step 2: Configure the AWS credentials (using AWS CLI) -
```bash
aws configure
```

Step 3: Run the commands given below in the `terraform/` directory -
```bash
terraform init
terraform plan
terraform apply --auto-approve
```

Step 4: After `terraform apply` completes, find the output `application_lb_dns_name`, which will be in the format - `host-application-lb-713503983.us-east-1.elb.amazonaws.com`.

Step 5: Copy and visit this URL in any browser to access the application page.

### Jenkins CI/CD Pipeline (Optional)
A Jenkins-based CI/CD pipeline is included for automating the entire flow — from Docker image build to infrastructure deployment.

Jenkins Pipeline Overview:
The Jenkinsfile in the root directory performs the following steps:

- `clone-repository` – Clones this GitHub repo (main branch).

- `build-image` – Builds the Docker image from the app/ folder.

- `push-to-dockerhub` – Pushes the image to DockerHub using credentials stored in Jenkins.

- `terraform-init-apply` – Initializes and applies Terraform code from the terraform/ folder.

#### Requirements:

- Jenkins server (locally or hosted)
- Docker installed on the Jenkins agent
- AWS credentials set on the Jenkins agent (via environment or IAM)
- DockerHub credentials stored in Jenkins (with ID: dockerhub-credentials)

#### How to Use:

Step 1: Fork or push this repo to your own GitHub account.

Step 2: Add your Docker username to `push-to-dockerhub` stage.

Step 3: Create a new Jenkins pipeline job.

Step 4: Set the Pipeline script to use Jenkinsfile from your GitHub repository.

Step 5: Run the pipeline to trigger the complete build and deployment process.

#### Feel free to email me at *moazinmir@gmail.com* if you encounter any issues.