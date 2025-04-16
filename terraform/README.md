## **Terraform Infrastructure**

This directory contains the Infrastructure-as-Code (IaC) setup used to deploy the containerized microservice on AWS using ECS Fargate.

## What It Does

- Provisions a new **VPC** with public/private subnets
- Creates a **Security Group** and **IAM Roles**
- Sets up an **Application Load Balancer**
- Configures an **ECS Cluster** and **Fargate Task Definition**
- Deploys the Dockerized app via **ECS Service**

## Prerequisites

- Terraform CLI installed
- AWS CLI configured (`aws configure`)
- Docker image pushed to DockerHub (used in ECS Task)

## How to Use

```bash
terraform init
terraform plan
terraform apply --auto-approve