# DevOps Portfolio - AWS EKS Platform

Terraform + Amazon EKS + Docker + Amazon ECR + GitHub Actions で構築した
Cloud Native DevOps Platformです。

## Overview

このプロジェクトでは、AWS上にKubernetes環境をTerraformで構築し、
DockerコンテナをEKSへCI/CDデプロイする一連のDevOpsフローを実装しています。

## Architecture

Developer
|
| git push
v
GitHub Actions
|
+-- Docker Build
|
+-- Push Image
|
v
Amazon ECR
|
v
Amazon EKS
|
+-- Deployment
+-- Service
+-- HPA
|
v
Application Pod


## Technology Stack

### Infrastructure

| Technology | Purpose |
|---|---|
| Terraform | Infrastructure as Code |
| Amazon VPC | Network |
| Amazon EKS | Kubernetes Cluster |
| IAM | Access Control |
| CloudWatch Logs | EKS Control Plane Logging |
| Amazon ECR | Container Registry |

### Application

| Technology | Purpose |
|---|---|
| Docker | Container Image |
| Kubernetes | Application Deployment |
| GitHub Actions | CI/CD Pipeline |

---

# Infrastructure Structure

terraform/
├── bootstrap/
│ └── Terraform Backend
│
├── modules/
│ ├── vpc/
│ ├── eks/
│ ├── ecr/
│ └── github-actions/
│
└── envs/
└── dev/


## Terraform Features

Implemented:

- Remote State management (S3 + DynamoDB)
- VPC creation
- Public / Private Subnet
- NAT Gateway
- EKS Cluster
- Managed Node Group
- EKS Access API
- EKS Add-ons
  - vpc-cni
  - kube-proxy
  - coredns
- CloudWatch Control Plane Logs
- ECR Repository
- GitHub Actions IAM Role (OIDC)

---

# Kubernetes Structure

k8s/
├── namespace.yaml
├── deployment.yaml
├── service.yaml
└── hpa.yaml


Features:

- Deployment with multiple replicas
- Service LoadBalancer
- Horizontal Pod Autoscaler

---

# Application

Simple Node.js application containerized with Docker.

app/
├── Dockerfile
├── package.json
└── server.js


Response example:

```json
{
  "message": "Hello from EKS!",
  "hostname": "pod-name"
}


Deployment Flow

1. Create Terraform Backend

cd terraform/bootstrap
terraform init
terraform apply

2. Deploy AWS Infrastructure

cd terraform/envs/dev
terraform init
terraform apply

Created resources:

VPC
EKS Cluster
Node Group
ECR Repository

3. Configure kubectl

aws eks update-kubeconfig \
  --region ap-northeast-1 \
  --name portfolio-eks

Check:

kubectl get nodes

4. Deploy Kubernetes Resources

kubectl apply -f k8s/

Check:

kubectl get pods -n portfolio

CI/CD Pipeline

When code is pushed to main branch:

GitHub Push
    |
    v
GitHub Actions
    |
    +-- Build Docker Image
    |
    +-- Push Image to ECR
    |
    +-- Update Kubernetes Deployment


Future Improvements
Possible improvements:

AWS Load Balancer Controller + Ingress
HTTPS with ACM
ArgoCD GitOps workflow
Prometheus / Grafana monitoring
Multi environment (dev/staging/prod)
Security scanning
