terraform {
  backend "gcs" {
    bucket  = "prod-tf-state-gcp"
    prefix  = "prod/terraform/state"
  }
}