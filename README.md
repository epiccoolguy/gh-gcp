# gh-gcp

Set up integration between Github and Google Cloud Platform.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Installation

1. Temporarily delete `backend.tf` so that Terraform can initialize locally.
2. Run `terraform init`
3. Run `terraform apply`
4. Create a `gcs.conf` file that contains the GCS bucket name output by Terraform during apply:

   ```conf
   bucket = "tfstate-xxxx"
   ```

5. Restore `backend.tf`
6. Run `terraform init` to migrate the Terraform state to GCS.
7. Create a fine-grained personal access token on Github with access to this repository and the following repository permissions:
   - Read access to metadata
   - Read and Write access to secrets
8. Store the Github personal access token as secret in this repository:

   ```sh
   echo "github_pat_xxx" | gh secret set GH_SECRETS_TOKEN --repo="epiccoolguy/gh-gcp"
   ```

## Usage

Instructions on how to use the project and any relevant examples.

## License

This project is licensed under the terms of the license provided in the [LICENSE](./LICENSE) file.
