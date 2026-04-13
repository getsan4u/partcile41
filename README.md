# SimpleTimeService

SimpleTimeService is a lightweight containerized microservice that returns the current timestamp and the client IP address in JSON format.

## 🚀 Overview

This project demonstrates a complete DevOps workflow:

- Build a simple web service
- Containerize it using Docker
- Publish the image to a public registry (GHCR)
- Deploy infrastructure on AWS using Terraform
- Run the application securely in private subnets
- Expose it to the internet via an Application Load Balancer

---

## 🏗 Architecture

I chose **AWS ECS Fargate with an Application Load Balancer**.

### Why ECS Fargate?
- No need to manage servers (fully managed)
- Simpler than Kubernetes (EKS) for a single microservice
- Faster to deploy and easier for teams to understand
- Cost-efficient for small workloads

### Architecture Design

- VPC with:
  - Public subnets → ALB
  - Private subnets → ECS tasks
- ECS Fargate runs the container in **private subnets only**
- ALB (public) routes traffic to ECS
- NAT Gateway allows ECS tasks to pull images from GHCR

Internet → ALB (Public Subnet) → ECS Fargate (Private Subnet)

---

## 📁 Repository Structure

```bash
.
├── app/
│   ├── app.py
│   ├── requirements.txt
│   ├── Dockerfile
│   └── .dockerignore
├── terraform/
│   ├── backend.tf
│   ├── networking.tf
│   ├── security_groups.tf
│   ├── load_balancer.tf
│   ├── ecs.tf
│   ├── iam.tf
│   ├── cloudwatch.tf
│   ├── variables.tf
│   ├── terraform.tfvars
│   ├── provider.tf
│   ├── versions.tf
│   └── outputs.tf
└── bootstrap/
    └── backend/
        ├── main.tf
        ├── provider.tf
        └── versions.tf
```
---


## 📦 Container Image

The application image is publicly available on GHCR:

```bash
ghcr.io/getsan4u/particle41-time-service:latest
```
---

## 🧰 Prerequisites

- Git → https://git-scm.com/downloads  
- Docker → https://docs.docker.com/get-docker/  
- Terraform → https://developer.hashicorp.com/terraform/downloads  
- AWS CLI → https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html  

---

## 🔐 AWS Authentication

⚠️ No credentials are stored in this repository.
```bash
aws configure
```

Or:

```bash
aws configure --profile personal-ssg
export AWS_PROFILE=personal-ssg
```

Verify:

```bash
aws sts get-caller-identity
```
---

## 🐳 Build & Push Docker Image (if needed)

```bash
docker buildx build \
  --platform linux/amd64 \
  -t ghcr.io/getsan4u/particle41-time-service:latest \
  --push .
```
---

## ☁️ Deploy Infrastructure

```bash
cd terraform

terraform init
terraform plan
terraform apply
```
---

## 🌐 Access the Application

After deployment:
```bash
http://<alb-dns>
```
Test:
```bash
curl http://<alb-dns>/ | jq
```
---

## 📄 Example Response
```JSON
{
  "timestamp": "2026-04-13T16:27:46.907351+00:00",
  "ip": "223.181.14.182"
}
```
---

## 🧹 Cleanup

```bash
cd infrastructure
terraform destroy
```