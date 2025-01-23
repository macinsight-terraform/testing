terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.50.0"  # Use the desired version
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "openstack" {
  auth_url           = "https://keystone.services.a.regiocloud.tech"
  user_name          = "hergemoeller"
  password           = var.os_password
  user_domain_name   = "b1systems"
  project_domain_id  = "b2341addab75466ab4c0fefb4fd07f6a"
  region             = "RegionA"
}

provider "cloudflare" {
  api_token = var.cf_api_token
}
