# Local Values
## Label/Resource Naming
locals {
  env_str          = "stg"
  infra_repository = "example-svc-terraform"

  lvgs_service_strs = {
    kebab = "example-svc"
    snake = "example_svc"
  }
}

## Regions & Zones
locals {
  project = "example-svc-stg"

  regions = {
    tokyo = "asia-northeast1"
  }

  zones = {
    zone_a = "${local.regions["tokyo"]}-a"
    zone_b = "${local.regions["tokyo"]}-b"
    zone_c = "${local.regions["tokyo"]}-c"
  }
}
