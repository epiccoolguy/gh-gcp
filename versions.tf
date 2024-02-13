terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.45.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.15.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.15.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
  }
}
