module "kms" {
  source = "../kms"
  providers = {
    google-beta = google-beta
  }

  project_id     = var.project_id
  project_number = var.project_number
  name           = var.name
  location       = var.location
  owner          = var.admin
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
