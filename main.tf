locals {
  gcp_project_id_prefix                     = "gha-wif"
  gcp_root_folder_name                      = "Github"
  gcp_workload_identity_attribute_condition = "assertion.repository=='${var.gh_owner}/${var.gh_repository}'"
}

module "folder_gh" {
  source = "terraform-google-modules/folders/google"

  names  = [local.gcp_root_folder_name]
  parent = "organizations/${var.gcp_organization_id}"
}

module "folder_gh_owner" {
  source = "terraform-google-modules/folders/google"

  names  = [var.gh_owner]
  parent = module.folder_gh.id
}

module "project" {
  source = "terraform-google-modules/project-factory/google"

  name              = var.gh_repository
  random_project_id = true
  org_id            = var.gcp_organization_id
  billing_account   = var.gcp_billing_account_id
  folder_id         = module.folder_gh_owner.id

  activate_apis = [
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudkms.googleapis.com"
  ]
}

module "bucket" {
  source = "./modules/bucket"

  project_id     = module.project.project_id
  project_number = module.project.project_number
  name           = var.gcp_tfstate_bucket_name
  location       = var.gcp_location
  storage_class  = "STANDARD"
  admin          = "serviceAccount:${module.project.service_account_email}"
}

module "workload_identity" {
  source = "./modules/workload_identity"

  project_id           = module.project.project_id
  pool_name            = var.gcp_workload_identity_pool_name
  provider_name        = var.gcp_workload_identity_provider_name
  random_pool_name     = true
  random_provider_name = true
  attribute_condition  = local.gcp_workload_identity_attribute_condition
}

module "folder_gh_owner_iam_bindings" {
  source = "terraform-google-modules/iam/google//modules/folders_iam"

  folders = [module.folder_gh_owner.id]
  bindings = {
    "roles/owner" = [
      "serviceAccount:${module.project.service_account_email}"
    ],

    "roles/resourcemanager.folderViewer" = [
      "serviceAccount:${module.project.service_account_email}"
    ],

    "roles/resourcemanager.folderCreator" = [
      "serviceAccount:${module.project.service_account_email}"
    ],
  }
}

module "billing_account_iam_bindings" {
  source = "terraform-google-modules/iam/google//modules/billing_accounts_iam"

  billing_account_ids = [var.gcp_billing_account_id]
  bindings = {
    "roles/billing.user" = [
      "serviceAccount:${module.project.service_account_email}"
    ]
  }
}

module "workload_identity_iam_bindings" {
  source = "terraform-google-modules/iam/google//modules/service_accounts_iam"

  project          = module.project.project_id
  service_accounts = [module.project.service_account_email]
  bindings = {
    "roles/iam.workloadIdentityUser" = [
      "principalSet://iam.googleapis.com/${module.workload_identity.pool.name}/attribute.repository/${var.gh_owner}/${var.gh_repository}"
    ]
  }
}

module "gh_secrets" {
  source = "./modules/gh"

  gh_repository                  = var.gh_repository
  gcp_organization_id            = var.gcp_organization_id
  gcp_folder_id                  = module.folder_gh_owner.id
  gcp_billing_account_id         = var.gcp_billing_account_id
  gcp_project_id                 = module.project.project_id
  gcp_tfstate_bucket_name        = module.bucket.names["${var.gcp_tfstate_bucket_name}"]
  gcp_service_account_email      = module.project.service_account_email
  gcp_workload_identity_provider = module.workload_identity.provider.name
}
