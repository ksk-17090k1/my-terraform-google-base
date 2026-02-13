# Backend
terraform {
  required_version = "<terraform_version>"

  required_providers {
    google = "<terraform_google_provider_version>"
  }

  backend "gcs" {
    bucket = "<dev_tfbackend_name>"
  }
}
