module "kms" {
  source  = "terraform-google-modules/kms/google"
  version = "~> 2.3.0"

  project_id          = var.project_id
  location            = var.location
  keyring             = var.name
  keys                = [var.name]
  key_rotation_period = "86400s"
  set_owners_for      = [var.name]
  owners              = [join(",", var.owners)]
}
