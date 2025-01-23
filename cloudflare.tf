resource "cloudflare_record" "k3s_master" {
  zone_id = var.cf_zone_id 
  name = var.cf_domain 
  type = "A"
  value = openstack_networking_floatingip_v2.k3s_master[0].address
  ttl = 300
  proxied = false
}