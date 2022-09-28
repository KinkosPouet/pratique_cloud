terraform {
  required_version = ">= 0.14.0" # Prend en compte les versions de terraform à partir de la 0.14.0
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.47.0"
    }

    ovh = {
      source  = "ovh/ovh"
      version = ">= 0.13.0"
    }
  }
}

provider "openstack" {
  auth_url    = "https://auth.cloud.ovh.net/v3/" # URL d'authentification
  domain_name = "default"                        # Toujours à "default" pour OVHcloud
  alias       = "ovh"                            # Un alias

  region = "SBG5"
}

provider "ovh" {
  endpoint = "ovh-eu" # Provider entry point
  alias    = "ovh"    # Provider alias
}
