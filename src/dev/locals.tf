# Local Values
## Label/Resource Naming
locals {
  env_str          = "dev"
  infra_repository = "example-svc-terraform"

  lvgs_service_strs = {
    kebab = "example-svc"
    snake = "example_svc"
  }
}

## File Path
locals {
  tmpl_dir = "../../tmpl"
}

## Regions & Zones
locals {
  project = "example-svc-dev"

  regions = {
    tokyo = "asia-northeast1"
  }

  zones = {
    zone_a = "${local.regions["tokyo"]}-a"
    zone_b = "${local.regions["tokyo"]}-b"
    zone_c = "${local.regions["tokyo"]}-c"
  }
}
