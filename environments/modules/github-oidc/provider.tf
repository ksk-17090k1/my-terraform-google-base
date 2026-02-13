# Provider
provider "google" {
  project                                       = var.project
  region                                        = local.region
  add_terraform_attribution_label               = true
  terraform_attribution_label_addition_strategy = "PROACTIVE"

  default_labels = {
    env        = var.env_str
    repository = local.infra_repository
  }
}
