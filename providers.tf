terraform {
  required_version = ">= 0.12"
  required_providers {
    oci = {
      source = "hashicorp/oci"
      version = ">=4.23"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">=2.8.0"
    }
  }
}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid = var.user_ocid
  fingerprint = var.fingerprint
  private_key_path = var.private_key_path
  region = var.region
}

provider digitalocean {
  token     = var.do_token
  api_endpoint = var.api_endpoint
}
