locals {
  github_actions_roles = [
    "roles/bigquery.dataEditor",
    "roles/bigquery.jobUser",
    "roles/artifactregistry.writer",
    "roles/run.admin",
    "roles/iam.serviceAccountUser"
  ]
}

resource "google_project_iam_member" "github_actions_roles" {
  for_each = toset(local.github_actions_roles)
  project  = var.project_id
  role     = each.key
  member   = "serviceAccount:${var.github_actions_service_account_email}"
}
