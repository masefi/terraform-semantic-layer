resource "google_cloud_run_service_iam_member" "ui_public" {
  location = var.region
  project  = var.project_id
  service  = "semantic-ui"
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_cloud_run_service_iam_member" "api_public" {
  location = var.region
  project  = var.project_id
  service  = "semantic-api"
  role     = "roles/run.invoker"
  member   = "allUsers"
}
