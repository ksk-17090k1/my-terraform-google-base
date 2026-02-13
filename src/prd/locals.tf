# Local Values
## Label/Resource Naming
locals {
  env_str          = "prd"
  infra_repository = "<github_repository_name>"

  lvgs_service_strs = {
    kebab = "<service_kebab_name>"
    snake = "<service_snake_name>"
  }
}

## File Path
locals {
  tmpl_dir = "../../tmpl"
}

## Regions & Zones
locals {
  project = "<google_cloud_prd_project_id>"

  regions = {
    tokyo = "asia-northeast1"
  }

  zones = {
    zone_a = "${local.regions["tokyo"]}-a"
    zone_b = "${local.regions["tokyo"]}-b"
    zone_c = "${local.regions["tokyo"]}-c"
  }
}
