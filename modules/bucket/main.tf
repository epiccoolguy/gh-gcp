module "kms" {
  source = "../kms"

  project_id = var.project_id
  name       = var.name
  location   = var.location
  owners = [
    var.admin,
    "serviceAccount:service-${var.project_number}@gs-project-accounts.iam.gserviceaccount.com"
  ]
}

module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google"
  version = "~> 5.0.0"

  project_id       = var.project_id
  location         = var.location
  names            = [var.name]
  randomize_suffix = true
  storage_class    = var.storage_class
  versioning = {
    enabled = true
  }
  encryption_key_names = {
    (var.name) = module.kms.keys["${var.name}"]
  }
  bucket_admins = {
    (var.name) = var.admin
  }
}
