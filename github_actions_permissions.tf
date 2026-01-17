locals {
  github_actions_roles = [
    # BigQuery permissions (for dbt)
    "roles/bigquery.dataEditor",
    "roles/bigquery.jobUser",
    
    # Cloud Run deployment permissions
    "roles/run.admin",
    "roles/iam.serviceAccountUser",
    
    # Container build & storage permissions
    "roles/artifactregistry.writer",
    "roles/storage.admin",
    "roles/cloudbuild.builds.editor",
    
    # Service usage (required for Cloud Build)
    "roles/serviceusage.serviceUsageConsumer",
  ]
}

resource "google_project_iam_member" "github_actions_roles" {
  for_each = toset(local.github_actions_roles)
  project  = var.project_id
  role     = each.key
  member   = "serviceAccount:${var.github_actions_service_account_email}"
}
