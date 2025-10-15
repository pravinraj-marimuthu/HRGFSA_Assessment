# A Simple Hello App Deployment and Infrastructure Management using AWS EKS, Terraform and GitHub Actions.

## Overview

This project demonstrates a fully automated DevOps pipeline for deploying a simple Python web application to AWS EKS. It includes containerization, infrastructure as code, CI/CD automation, monitoring, and observability.

**Core Features:**

- **Application Containerization:** Python application containerized with Docker and deployed on Kubernetes.
- **Automated Deployment:** GitHub Actions triggers a CI/CD pipeline on every push to the `main` branch.
- **Infrastructure as Code:** AWS infrastructure (VPC, EKS cluster, ECR repository) is provisioned using Terraform.
- **Monitoring & Observability:** Prometheus and Grafana gather and visualize application and cluster metrics.

**Best Practices Implemented:**

- Secrets management for Grafana and Prometheus credentials.
- Observability with Grafana dashboards and Prometheus metrics.
- Multi-stage Build usage to optimize the Docker image size 
- Buildx setup to improve caching and build speed

---

## Setup Instructions

### Pre-requisites

1. Docker 
2. Kubernetes
3. Helm
4. Terraform
5. AWS CLI

### 1. Clone the Repository

```bash
git clone (https://github.com/pravinraj-marimuthu/HRGFSA_Assessment/)
cd HRGFSA_Assessment
```

### 2. Configure AWS Credentials

```bash
export AWS_ACCESS_KEY_ID=<your-access-key>
export AWS_SECRET_ACCESS_KEY=<your-secret-key>
export AWS_REGION=ap-south-1
```

### 3. Provision Infrastructure (Terraform)

```bash
terraform init
terraform plan
terraform apply
```
Creates VPC, EKS cluster, and ECR repository.

### 4. Deploy Application (CI/CD)

- Push to main triggers GitHub Actions pipeline:
- Builds Docker image.
- Pushes image to AWS ECR.
- Applies Kubernetes manifests.
- Deploys Prometheus and Grafana for monitoring.

### 5. Access Services

- Application: [application-website](http://acaa9573b09c141d3a0b6041b5e68b90-946784810.ap-south-1.elb.amazonaws.com/)
- Execute below command to access the grafana using [grafana-website](http://localhost:3000/)
```bash
nohup kubectl port-forward svc/prometheus-grafana 3000:80 -n monitoring > /tmp/grafana.log 2>&1 &
```

## Design Choices

- Python Application: Lightweight and easy to containerize.
- Multi-stage Docker Build: Reduces image size and improves build speed.
- AWS EKS: Managed Kubernetes simplifies cluster operations.
- Terraform IaC: Provides reproducible and versioned infrastructure deployment.
- GitHub Actions CI/CD: Fully automated deployment on code changes.
- Observability: Prometheus and Grafana dashboards monitor app and cluster health.
- Secrets Management: Sensitive data stored securely in Kubernetes secrets.

## Proof Of Concepts

- Screenshots - https://github.com/pravinraj-marimuthu/HRGFSA_Assessment/blob/main/screenshots/snips.md
- Video Presentations - https://www.loom.com/share/ae422bf7a7694629912dc2228b017564

## Live Application

- Application URL: [application](http://acaa9573b09c141d3a0b6041b5e68b90-946784810.ap-south-1.elb.amazonaws.com/)
- Grafana Dashboard: [grafana](http://localhost:3000/)
