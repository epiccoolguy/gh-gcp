output "gcp_organization_id" {
  value = var.gcp_organization_id
}

output "gcp_billing_account_id" {
  value = var.gcp_billing_account_id
}

output "gcp_folder_id" {
  value = module.folder_gh_owner.id
}

output "gcp_project_id" {
  value = module.project.project_id
}

output "gcp_tfstate_bucket_name" {
  value = module.bucket.names["${var.gcp_tfstate_bucket_name}"]
}

output "gcp_service_account_email" {
  value = module.project.service_account_email
}

output "gcp_workload_identity_provider" {
  value = module.workload_identity.provider.name
}
