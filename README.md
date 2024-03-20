# terraform-flux-github-repo-key

This module deploys the `tls_private_key` resource (see [Bootstrap with GitHub](https://registry.terraform.io/providers/fluxcd/flux/latest/docs/guides/github)) and saves the pem content as an AWS secret so it can then be reference to [terraform-github-repository](https://registry.terraform.io/modules/yivolve/github/flux/latest). The intention of separating the `tls_private_key` resource creation from the actual Flux bootstrap is to avoid failures when unisntalling Flux through the same terraform configuration which currently happens cause the `private_pem_key` gets destroyed before Flux is uninstalled, hence the unintallation fails.

## How to use this module with Terragrunt

```hcl
terraform {
  source = "tfr:///yivolve/github-repo-key/flux?version=<tag version>"
}

<optional terragrunt's configuration goes here>

inputs = {
  title                   = <title>
  description             = <description>
  ...The rest of the inputs go here
}

```

### Provider Configuration

Ideally you would have the configuration below on a file that can be passed to multiple terragrunt child files:

```hcl
generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    terraform {
      required_version = "<version>"
      required_providers {
        github = {
          source  = "integrations/github"
          version = "<version>"
        }
        github = {
          source  = "fluxcd/flux"
          version = "<version>"
        }
      }
    }

    variable "github_token" {
      sensitive = true
      type      = string
    }

    provider "github" {
      owner = "<github owner>"
      token = var.github_token
    }
EOF
}
```
