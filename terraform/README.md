## **Terraform Infrastructure**

This directory contains the Infrastructure-as-Code (IaC) setup used to deploy the containerized microservice on AWS using ECS Fargate. 

## What It Does

- Provisions a new **VPC** with public/private subnets
- Creates a **Security Group** and **IAM Roles**
- Sets up an **Application Load Balancer**
- Configures an **ECS Cluster** and **Fargate Task Definition**
- Deploys the Dockerized app via **ECS Service**

To deploy my simple-time-service containerized application on AWS ECS, I set up a complete infrastructure using Terraform. I started with creating a VPC that includes both public and private subnets to isolate internal components from the public internet while still allowing access where needed. I created an ECS cluster to manage the deployment of my containers and attached an IAM role to grant necessary permissions for ECS tasks to interact with AWS services securely. I defined a task definition to specify how the container should run, including the image, resource allocation, and networking settings. To expose the application to users, I used an Application Load Balancer (ALB) along with target groups and listeners to handle incoming traffic. I also configured security groups and ingress rules to control traffic flow securely between the load balancer and ECS tasks. Lastly, I created an ECS service that runs and manages my container, handles load balancing, and ensures high availability, effectively setting up a production-ready environment for my app.

## Prerequisites

- Terraform CLI installed
- AWS CLI configured (`aws configure`)
- Docker image pushed to DockerHub (used in ECS Task)

## How to Use

```bash
terraform init
terraform plan
terraform apply --auto-approve
