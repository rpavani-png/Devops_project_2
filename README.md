GCP Infrastructure Pipeline Using Terraform & GitHub Actions

Project Overview

This project implements a fully automated Infrastructure as Code (IaC) pipeline on Google Cloud Platform (GCP) using Terraform and GitHub Actions. It provisions and manages a multi-environment setup (Dev and Prod) with strong emphasis on security, isolation, and governance.

Key Features

Multi-environment infrastructure (Dev & Prod)
Reusable Terraform module (DRY principle)
Remote state management using GCS
PR-based safety checks (Terraform Plan only)
Automated Dev deployment on merge
Manual approval gate for Production deployment
Secure credential management via GitHub Secrets

Architecture

Components Provisioned
VPC Network (Custom mode)
Subnetwork (Region-specific CIDR)
Firewall Rule (SSH access on port 22)
Compute Engine VM (Region-aligned zone)
Cloud Storage Bucket (Globally unique name)
Environment Separation
Feature	Dev	Prod
Region	us-central1	us-east1
Subnet CIDR	10.0.1.0/24	10.1.1.0/24
Deployment	Automatic	Manual Approval
Backend	GCS (dev bucket)	GCS (prod bucket)

Repository Structure

GCP_resource_creation
.
├── README.md
├── envs
│   ├── dev
│   │   ├── backend.tf
│   │   ├── dev.tfvars
│   │   ├── main.tf
│   │   └── variables.tf
│   └── prod
│       ├── backend.tf
│       ├── main.tf
│       ├── prod.tfvars
│       └── variables.tf
└── modules
    └── infra
        ├── compute.tf
        ├── firewall.tf
        ├── main.tf
        ├── network.tf
        ├── outputs.tf
        ├── storage.tf
        └── variables.tf

Terraform Setup

Initialize Terraform
cd envs/dev
terraform init

Plan
terraform plan -var-file=dev.tfvars

Apply
terraform apply -var-file=dev.tfvars

Destroy
terraform destroy -var-file=dev.tfvars

CI/CD Pipeline
1. PR Safety Check Workflow

Trigger: Pull Request to main

Runs terraform init and terraform plan
Executes for both Dev and Prod
Does NOT run terraform apply

2. Deployment Workflow

Trigger: Push to main

Dev Deployment
Automatically runs terraform apply
No manual approval required
Prod Deployment
Requires manual approval via GitHub Environments
Runs only after Dev deployment succeeds

🔐 Security
GCP credentials stored in GitHub Secrets (GCP_SA_KEY)
No hardcoded secrets in code
Remote state stored in GCS buckets

🌍 GitHub Environments
DEV
No approval required
PROD
Requires manual approval
Protected with reviewers

📊 Example Workflow Behavior
Action	Result
Open PR	Runs Terraform Plan (Dev + Prod)
Merge to Main	Applies Dev automatically
Prod Stage	Waits for approval
Approval Given	Applies Prod

📷 Deliverables
Terraform module code
GitHub Actions workflows
Plan output logs (PR)
Screenshot of Prod approval gate

Architecture diagram
✅ Best Practices Followed
No hardcoding of environment values
Separate state backends for each environment
Fail-fast pipeline design
Environment isolation

📚 Learning Outcomes
Terraform module design
Remote state management
GitHub Actions CI/CD pipelines
Secure cloud deployments
Infrastructure governance with approval gates
🧑‍💻 Author

Naga Pavani

📌 Notes
Ensure terraform init is run before plan/apply
Always use correct tfvars file per environment
Production changes require manual approval
📈 Future Improvements
Add monitoring & logging
Integrate Terraform Cloud
Add automated testing for infrastructure