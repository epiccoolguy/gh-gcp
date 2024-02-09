resource "github_actions_secret" "gcp_organization_id" {
  secret_name     = "GCP_ORGANIZATION_ID"
  plaintext_value = var.gcp_organization_id
  repository      = var.gh_repository
}

resource "github_actions_secret" "gcp_folder_id" {
  secret_name     = "GCP_FOLDER_ID"
  plaintext_value = var.gcp_folder_id
  repository      = var.gh_repository
}

resource "github_actions_secret" "gcp_billing_account_id" {
  secret_name     = "GCP_BILLING_ACCOUNT_ID"
  plaintext_value = var.gcp_billing_account_id
  repository      = var.gh_repository
}

resource "github_actions_secret" "gcp_project_id" {
  secret_name     = "GCP_PROJECT_ID"
  plaintext_value = var.gcp_project_id
  repository      = var.gh_repository
}

resource "github_actions_secret" "gcp_tfstate_bucket_name" {
  secret_name     = "GCP_TFSTATE_BUCKET_NAME"
  plaintext_value = var.gcp_tfstate_bucket_name
  repository      = var.gh_repository
}

resource "github_actions_secret" "gcp_workload_identity_provider" {
  secret_name     = "GCP_WORKLOAD_IDENTITY_PROVIDER"
  plaintext_value = var.gcp_workload_identity_provider
  repository      = var.gh_repository
}
