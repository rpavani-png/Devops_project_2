provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "infra" {
  source = "../../modules/infra"

  project_id  = var.project_id
  region      = var.region
  zone        = var.zone
  subnet_cidr = var.subnet_cidr
  env         = var.env
}