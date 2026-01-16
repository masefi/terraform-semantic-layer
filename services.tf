locals {
  services = [
    "aiplatform.googleapis.com",      # Vertex AI
    "bigquery.googleapis.com",        # BigQuery
    "artifactregistry.googleapis.com", # Artifact Registry
    "run.googleapis.com",             # Cloud Run
    "iam.googleapis.com",              # IAM
    "cloudbuild.googleapis.com"        # Cloud Build
  ]
}

resource "google_project_service" "project_services" {
  for_each = toset(local.services)
  project  = var.project_id
  service  = each.key

  disable_on_destroy = false
}
