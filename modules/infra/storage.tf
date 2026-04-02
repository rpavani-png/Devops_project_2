resource "google_storage_bucket" "bucket" {
  name     = "${var.project_id}-${var.env}-bucket"
  location = var.region
}