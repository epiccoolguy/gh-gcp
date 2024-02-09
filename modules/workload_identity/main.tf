resource "random_id" "random_pool_name_suffix" {
  byte_length = 2
}

resource "random_id" "random_provider_name_suffix" {
  byte_length = 2
}

resource "google_iam_workload_identity_pool" "pool" {
  project                   = var.project_id
  workload_identity_pool_id = var.random_pool_name ? "${var.pool_name}-${random_id.random_pool_name_suffix.hex}" : var.pool_name
}

resource "google_iam_workload_identity_pool_provider" "provider" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.random_provider_name ? "${var.provider_name}-${random_id.random_provider_name_suffix.hex}" : var.provider_name
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  attribute_condition = var.attribute_condition
  oidc {
    issuer_uri        = "https://token.actions.githubusercontent.com"
    allowed_audiences = []
  }
}
