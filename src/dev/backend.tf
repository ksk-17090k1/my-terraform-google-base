# Backend
terraform {
  required_version = "1.12.2"

  required_providers {
    google = "6.41.0"
  }

  backend "gcs" {
    bucket = "example-svc-dev-terraform-backend"
  }
}
