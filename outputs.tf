output "retail_marts_dataset" {
  value = google_bigquery_dataset.retail_marts.dataset_id
}

output "retail_public_demo_dataset" {
  value = google_bigquery_dataset.retail_public_demo.dataset_id
}
