terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.50.0"  # Use the desired version
    }
  }
}

provider "openstack" {
  auth_url           = "https://keystone.services.a.regiocloud.tech"
  user_name          = "hergemoeller"
  password           = var.os_password
  project_name       = "b1systems-sandbox"
  user_domain_name   = "b1systems"
  project_domain_id  = "b2341addab75466ab4c0fefb4fd07f6a"
  region             = "RegionA"
}
variable "os_password" {
  description = "Openstack password"
  type = string
}
