# Provider
provider "google" {
  project                                       = local.project
  region                                        = local.regions["tokyo"]
  add_terraform_attribution_label               = true
  terraform_attribution_label_addition_strategy = "PROACTIVE"

  default_labels = {
    env        = local.env_str
    repository = local.infra_repository
  }
}
