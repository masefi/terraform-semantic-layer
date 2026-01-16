resource "google_bigquery_dataset" "retail_marts" {
  dataset_id  = "retail_marts"
  project     = var.project_id
  location    = var.bq_location
  description = "Private dbt staging and mart models for retail analytics"

  delete_contents_on_destroy = false
}

resource "google_bigquery_dataset" "retail_public_demo" {
  dataset_id  = "retail_public_demo"
  project     = var.project_id
  location    = var.bq_location
  description = "Public demo dataset exposing curated retail analytics views"

  delete_contents_on_destroy = false
}

resource "google_bigquery_dataset_access" "public_read" {
  dataset_id = google_bigquery_dataset.retail_public_demo.dataset_id
  project    = var.project_id
  role       = "READER"
  special_group = "allAuthenticatedUsers"
}

resource "google_artifact_registry_repository" "retail_repo" {
  location      = var.region
  repository_id = "retail-repo"
  description   = "Docker repository for retail semantic layer UI and API"
  format        = "DOCKER"
}

