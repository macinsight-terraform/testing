variable "os_password" {
  description = "Openstack password"
  type = string
}
variable "cf_api_token" {
  description = "Cloudflare token"
  type = string
}

variable "cf_zone_id" {
  description = "Cloudflare Zone ID"
  type = string
}

variable "cf_domain" {
  description = "Cloudflare Domain"
  type = string
}

variable "private_ssh_key" {
  description = "Private SSH key for inter-instance access"
  type = string
  sensitive = true
}