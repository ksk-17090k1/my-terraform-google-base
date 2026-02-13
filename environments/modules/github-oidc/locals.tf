# Local Values
## Label/Resource Naming
locals {
  organization_str = "lvgs-aiml-engineering"
  infra_repository = "technology-strategy-gen-ai-google-terraform-base"

  lvgs_service_strs = {
    kebab       = "technology-strategy-gen-ai"
    snake       = "technology_strategy_gen_ai"
    kebab_short = "gen-ai"
    snake_short = "gen_ai"
  }
}

## Regions & Zones
locals {
  region = "asia-northeast1"
}

## GitHub Repositories
locals {
  application_github_repos = [
  ]

  terraform_github_repos = [
    "${local.organization_str}/technology-strategy-gen-ai-google-terraform-base"
  ]
}

## IAM Roles & Permissions
locals {
  application_cicd_permissions = [
    "roles/artifactregistry.writer",
    "roles/iam.serviceAccountUser",
    "roles/run.admin"
  ]

  terraform_cicd_permissions = {
    custom_roles = [
      "billing.resourcebudgets.read",
      "billing.resourcebudgets.write",
      "billing.resourceCosts.get",
      "resourcemanager.projects.get"
    ]

    predefined_roles = [
      "roles/artifactregistry.admin",
      "roles/cloudbuild.builds.editor",
      "roles/cloudfunctions.admin",
      "roles/cloudkms.admin",
      "roles/cloudscheduler.admin",
      "roles/cloudsql.admin",
      "roles/compute.admin",
      "roles/dns.admin",
      "roles/iam.roleAdmin",
      "roles/iam.securityAdmin",
      "roles/iam.serviceAccountAdmin",
      "roles/iam.serviceAccountUser",
      "roles/iam.workloadIdentityPoolAdmin",
      "roles/logging.admin",
      "roles/monitoring.admin",
      "roles/pubsub.admin",
      "roles/run.admin",
      "roles/secretmanager.admin",
      "roles/servicenetworking.networksAdmin",
      "roles/serviceusage.serviceUsageConsumer",
      "roles/storage.admin",
      "roles/vpcaccess.admin"
    ]
  }
}
