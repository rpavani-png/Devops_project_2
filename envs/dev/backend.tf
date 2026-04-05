terraform {
  backend "gcs" {
    bucket  = "dev-tf-state-gcp"
    prefix  = "dev/terraform/state"
  }
}