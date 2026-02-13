# Backend
terraform {
  required_version = "<terraform_version>"

  required_providers {
    google = "<terraform_google_provider_version>"
  }

  backend "gcs" {
    bucket = "<prd_tfbackend_name>"
  }
}
