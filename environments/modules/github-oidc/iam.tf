# IAM Workload Identity Pool
resource "google_iam_workload_identity_pool" "github" {
  workload_identity_pool_id = "${local.lvgs_service_strs["kebab_short"]}-${var.env_str}-github-actions"
  display_name              = "${local.lvgs_service_strs["kebab_short"]}-${var.env_str}-github-actions"
  description               = "Workload Identity Pool for GitHub Actions"
  disabled                  = false
}

# IAM Workload Identity Pool Provider
resource "google_iam_workload_identity_pool_provider" "github" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = "${local.lvgs_service_strs["kebab_short"]}-${var.env_str}-github-actions"
  display_name                       = "${local.lvgs_service_strs["kebab_short"]}-${var.env_str}-github-actions"
  description                        = "Workload Identity Pool Provider for GitHub Actions"
  disabled                           = false
  attribute_condition                = "assertion.repository_owner == '${local.organization_str}'"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
    "attribute.owner"      = "assertion.repository_owner"
  }
}

# IAM Service Account
## Application
resource "google_service_account" "application" {
  account_id   = "${local.lvgs_service_strs["kebab_short"]}-${var.env_str}-deployer-app"
  display_name = "${local.lvgs_service_strs["kebab_short"]}-${var.env_str}-deployer-app"
  description  = "Service Account for Application CI/CD"
}

resource "google_service_account_iam_member" "application" {
  for_each           = { for repo in local.application_github_repos : repo => repo }
  service_account_id = google_service_account.application.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository/${each.value}"
}

resource "google_project_iam_member" "application" {
  for_each = { for role in local.application_cicd_permissions : role => role }
  project  = var.project
  role     = each.value
  member   = google_service_account.application.member
}

## Terraform
resource "google_service_account" "terraform" {
  account_id   = "${local.lvgs_service_strs["kebab_short"]}-${var.env_str}-deployer-infra"
  display_name = "${local.lvgs_service_strs["kebab_short"]}-${var.env_str}-deployer-infra"
  description  = "Service Account for Terraform CI/CD"
}

resource "google_service_account_iam_member" "terraform" {
  for_each           = { for repo in local.terraform_github_repos : repo => repo }
  service_account_id = google_service_account.terraform.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository/${each.value}"
}

resource "google_project_iam_member" "terraform" {
  for_each = { for role in local.terraform_cicd_permissions["predefined_roles"] : role => role }
  project  = var.project
  role     = each.value
  member   = google_service_account.terraform.member
}

resource "google_project_iam_custom_role" "terraform" {
  title       = "${local.lvgs_service_strs["kebab_short"]}-${var.env_str}-custom-role-infra"
  role_id     = "${local.lvgs_service_strs["snake_short"]}.${var.env_str}_infra_custom_crud"
  description = "Custom Role for Terraform CI/CD"
  stage       = "GA"
  permissions = local.terraform_cicd_permissions["custom_roles"]
}

resource "google_project_iam_member" "terraform_custom" {
  project = var.project
  role    = google_project_iam_custom_role.terraform.id
  member  = google_service_account.terraform.member
}
