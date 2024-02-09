variable "gh_owner" {
  type    = string
  default = "epiccoolguy"
}

variable "gh_repository" {
  type    = string
  default = "gh-gcp"
}

variable "gcp_organization_id" {
  type = string
}

variable "gcp_billing_account_id" {
  type = string
}

variable "gcp_location" {
  type    = string
  default = "europe-west4"
}

variable "gcp_tfstate_bucket_name" {
  type    = string
  default = "tfstate"
}

variable "gcp_workload_identity_pool_name" {
  type    = string
  default = "githubactions"
}

variable "gcp_workload_identity_provider_name" {
  type    = string
  default = "epiccoolguy"
}
