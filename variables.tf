variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "bq_location" {
  description = "BigQuery dataset location"
  type        = string
  default     = "US"
}

variable "dbt_service_account_email" {
  description = "Email of the pre-created dbt Cloud service account"
  type        = string
}

variable "github_actions_service_account_email" {
  description = "Email of the GitHub Actions service account"
  type        = string
  default     = "github-actions-sa@semantic-layer-484020.iam.gserviceaccount.com"
}


