# Terraform - Semantic Layer Infrastructure

Infrastructure as Code (IaC) for the [Retail Semantic Layer](https://github.com/masefi/semantic-layer-dbt) project. Manages GCP IAM roles and service accounts.

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    GCP Project: semantic-layer-484020           │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │              Service Accounts                            │   │
│  ├─────────────────────────────────────────────────────────┤   │
│  │                                                         │   │
│  │  github-actions-sa          dbt-service-account         │   │
│  │  └── CI/CD Deployments      └── BigQuery Access         │   │
│  │                                                         │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │              Cloud Run Services                          │   │
│  ├─────────────────────────────────────────────────────────┤   │
│  │                                                         │   │
│  │  cube-semantic-layer    semantic-api     semantic-ui    │   │
│  │  └── Cube.js Server     └── FastAPI      └── Streamlit  │   │
│  │                                                         │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## 📁 File Structure

| File | Purpose |
|------|---------|
| `main.tf` | Provider configuration and project setup |
| `providers.tf` | Google Cloud provider settings |
| `variables.tf` | Input variables (project_id, region, etc.) |
| `versions.tf` | Terraform and provider version constraints |
| `services.tf` | GCP API enablement |
| `dbt_service_account.tf` | Service account for dbt/BigQuery access |
| `github_actions_permissions.tf` | IAM roles for GitHub Actions CI/CD |
| `cloud_run_public.tf` | Public access configuration for Cloud Run |
| `outputs.tf` | Output values (service account emails, etc.) |

## 🔐 IAM Roles

### GitHub Actions Service Account

Used by CI/CD pipeline to deploy services:

| Role | Purpose |
|------|---------|
| `roles/run.admin` | Deploy Cloud Run services |
| `roles/iam.serviceAccountUser` | Act as service accounts |
| `roles/storage.admin` | Push container images |
| `roles/cloudbuild.builds.editor` | Build containers |
| `roles/artifactregistry.writer` | Write to Artifact Registry |
| `roles/serviceusage.serviceUsageConsumer` | Use GCP services |

### dbt Service Account

Used for BigQuery data transformations:

| Role | Purpose |
|------|---------|
| `roles/bigquery.admin` | Full BigQuery access |
| `roles/bigquery.jobUser` | Run BigQuery jobs |

## 🚀 Usage

### Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 1.0
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- GCP Project with billing enabled

### Setup

```bash
# Authenticate with GCP
gcloud auth application-default login

# Initialize Terraform
terraform init

# Review planned changes
terraform plan

# Apply changes
terraform apply
```

### Variables

Create a `terraform.tfvars` file or set via environment:

```hcl
project_id                       = "semantic-layer-484020"
region                           = "us-central1"
dbt_service_account_email        = "dbt-service-account@semantic-layer-484020.iam.gserviceaccount.com"
github_actions_service_account_email = "github-actions-sa@semantic-layer-484020.iam.gserviceaccount.com"
```

## 🔗 Related Repositories

| Repository | Description |
|------------|-------------|
| [semantic-layer-dbt](https://github.com/masefi/semantic-layer-dbt) | Main application: dbt models, API, UI, Cube |

## 📊 Deployed Resources

After `terraform apply`, these resources are managed:

```
✅ Service Accounts
   ├── github-actions-sa (CI/CD)
   └── dbt-service-account (BigQuery)

✅ IAM Bindings
   ├── Cloud Run Admin
   ├── Storage Admin
   ├── BigQuery Admin
   └── Artifact Registry Writer

✅ Cloud Run Configurations
   └── Public access (allUsers invoker)
```

## 🔄 State Management

Terraform state is stored locally. For production, consider:

```hcl
# backend.tf
terraform {
  backend "gcs" {
    bucket = "semantic-layer-terraform-state"
    prefix = "terraform/state"
  }
}
```

## 📚 Resources

- [Terraform Google Provider Docs](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [GCP IAM Roles Reference](https://cloud.google.com/iam/docs/understanding-roles)
- [Cloud Run IAM](https://cloud.google.com/run/docs/securing/managing-access)
